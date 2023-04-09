import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:speaxpoint/models/allocated_role_player.dart';
import 'package:multiple_result/src/unit.dart';
import 'package:multiple_result/src/result.dart';
import 'package:speaxpoint/models/toastmaster.dart';
import 'package:speaxpoint/services/meeting_arrangement/allocate_role_players/i_allocate_role_players_service.dart';
import 'package:speaxpoint/services/meeting_arrangement/common_services/meeting_arrangement_common_firebase_services.dart';
import '../../failure.dart';

class AllocateRolePlayerFirebaseService
    extends MeetingArrangementCommonFirebaseServices
    implements IAllocateRolePlayersService {
  final CollectionReference _chapterMeetingsCollection =
      FirebaseFirestore.instance.collection('ChapterMeetings');

  final CollectionReference _toastmasterCollection =
      FirebaseFirestore.instance.collection('Toastmasters');
  @override
  Future<Result<Unit, Failure>> allocateNewRolePlayer(
      String chapterMeetingId, AllocatedRolePlayer allocatedRolePlayer) async {
    try {
      await super.getAllocatedRolePlayerCollectionRef(chapterMeetingId).then(
        (status) async {
          QuerySnapshot allocatedRolePlayerQS = await status.get();

          //this list is need to obtains the latest unique id number
          List<AllocatedRolePlayer> allocatedRolePlayerList =
              allocatedRolePlayerQS.docs
                  .map((e) => AllocatedRolePlayer.fromJson(
                      e.data() as Map<String, dynamic>))
                  .toList();

          int uniqueId = _getlNewtUniqueIdNumber(allocatedRolePlayerList);
          allocatedRolePlayer.allocatedRolePlayerUniqueId = uniqueId;
          await status
              .doc(uniqueId.toString())
              .set(allocatedRolePlayer.toJson());
        },
      );
      return Success.unit();
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location:
                "AllocateRolePlayerFirebaseService.allocateClubMemberNewRolePlayer()",
            message:
                e.message ?? "Database Error While allocating role player"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location:
                "AllocateRolePlayerFirebaseService.allocateClubMemberNewRolePlayer()",
            message: e.toString()),
      );
    }
  }

  @override
  Future<Result<Unit, Failure>> deleteAllocatedRolePlayer(
      String chapterMeetingId, int allocatedRolePlayerUniqueId) async {
    try {
      await super.getAllocatedRolePlayerCollectionRef(chapterMeetingId).then(
        (status) async {
          QuerySnapshot allocatedRolePlayerQS = await status
              .where("allocatedRolePlayerUniqueId",
                  isEqualTo: allocatedRolePlayerUniqueId)
              .get();
          await allocatedRolePlayerQS.docs.first.reference.delete();
        },
      );

      return Success.unit();
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location:
                "AllocateRolePlayerFirebaseService.deleteAllocatedRolePlayer()",
            message: e.message ?? "Database Error While deleting role player"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location:
                "AllocateRolePlayerFirebaseService.deleteAllocatedRolePlayer()",
            message: e.toString()),
      );
    }
  }

  @override
  Future<Result<bool, Failure>> validateIfRoleIsTaken(
    String chapterMeetingId,
    String roleName,
    int memberRolePlace,
  ) async {
    bool roleIsExisted = false;
    try {
      print("dsdsdsfsd fsdfsdf");
      await super.getAllocatedRolePlayerCollectionRef(chapterMeetingId).then(
        (value) async {
          QuerySnapshot tempQS = await value
              .where("roleName", isEqualTo: roleName)
              .where("roleOrderPlace", isEqualTo: memberRolePlace)
              .get();

          if (tempQS.docs.isEmpty) {
            roleIsExisted = true;
          }
        },
      );
      return Success(roleIsExisted);
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location:
                "AllocateRolePlayerFirebaseService.validateIfRoleIsTaken()",
            message: e.message ??
                "Database Error While validating allocated role player availability"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location:
                "AllocateRolePlayerFirebaseService.validateIfRoleIsTaken()",
            message: e.toString()),
      );
    }
  }

  @override
  Future<Result<Unit, Failure>> updateOccupiedRoleDetails(
      String chapterMeetingId, AllocatedRolePlayer allocatedRolePlayer) async {
    try {
      await super.getAllocatedRolePlayerCollectionRef(chapterMeetingId).then(
        (value) async {
          QuerySnapshot tempQS = await value
              .where("roleName", isEqualTo: allocatedRolePlayer.roleName)
              .where("roleOrderPlace",
                  isEqualTo: allocatedRolePlayer.roleOrderPlace)
              .get();
          if (tempQS.docs.isNotEmpty) {
            await tempQS.docs.first.reference.update(
              {
                'toastmasterUsername': allocatedRolePlayer.toastmasterUsername,
                'guestInvitationCode': allocatedRolePlayer.guestInvitationCode,
                'rolePlayerName': allocatedRolePlayer.rolePlayerName,
                'toastmasterId': allocatedRolePlayer.toastmasterId,
                'allocatedRolePlayerType':
                    allocatedRolePlayer.allocatedRolePlayerType,
              },
            );
          }
        },
      );
      return Success.unit();
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location:
                "AllocateRolePlayerFirebaseService.updateOccupiedRoleDetails()",
            message: e.message ??
                "Database Error While updating an occupied role detailes"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location:
                "AllocateRolePlayerFirebaseService.updateOccupiedRoleDetails()",
            message: e.toString()),
      );
    }
  }

  //this method will search for the last and biggest UniqueId and then add one to it
  int _getlNewtUniqueIdNumber(List<AllocatedRolePlayer> list) {
    int biggestAgendaCardNumber = 0;

    if (list.isNotEmpty) {
      return biggestAgendaCardNumber = list.fold(
            biggestAgendaCardNumber,
            (previousValue, element) =>
                max(previousValue, element.allocatedRolePlayerUniqueId!),
          ) +
          1;
    } else {
      return biggestAgendaCardNumber += biggestAgendaCardNumber + 1;
    }
  }

  @override
  Future<Result<Toastmaster, Failure>> searchOtherClubsMember(
      String toastmasterUsername) async {
    try {
      Toastmaster toastmaster;
      QuerySnapshot checkUserHasExitedDocument = await _toastmasterCollection
          .where("toastmasterUsername", isEqualTo: toastmasterUsername)
          .get();

      if (checkUserHasExitedDocument.docs.isNotEmpty) {
        //since each user will have only on 1 document always get the first document
        toastmaster = Toastmaster.fromJson(checkUserHasExitedDocument.docs.first
            .data() as Map<String, dynamic>);
      } else {
        return const Error(
          Failure(
            code: "no-member-found",
            message: "no member record cannot be found in the database.",
            location:
                "AllocateRolePlayerFirebaseService.searchOtherClubsMember()",
          ),
        );
      }
      return Success(toastmaster);
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location:
                "AllocateRolePlayerFirebaseService.searchOtherClubsMember()",
            message:
                e.message ?? "Database Error While getting member detials"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location:
                "AllocateRolePlayerFirebaseService.searchOtherClubsMember()",
            message: e.toString()),
      );
    }
  }
}
