import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:speaxpoint/models/allocated_role_player.dart';
import 'package:multiple_result/src/unit.dart';
import 'package:multiple_result/src/result.dart';
import 'package:speaxpoint/services/meeting_arrangement/allocate_role_players/i_allocate_role_players_service.dart';
import 'package:speaxpoint/services/meeting_arrangement/common_services/meeting_arrangement_common_firebase_services.dart';
import '../../failure.dart';

class AllocateRolePlayerFirebaseService
    extends MeetingArrangementCommonFirebaseServices
    implements IAllocateRolePlayersService {
  final CollectionReference _chapterMeetingsCollection =
      FirebaseFirestore.instance.collection('ChapterMeetings');
  @override
  Future<Result<Unit, Failure>> allocateClubMemberNewRolePlayer(
      String chapterMeetingId, AllocatedRolePlayer allocatedRolePlayer) async {
    try {
      await _getAllocatedRolePlayerCollectionRef(chapterMeetingId).then(
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
      String chapterMeetingId, String allocatedRolePlayerUniqueId) async {
    try {
      await _getAllocatedRolePlayerCollectionRef(chapterMeetingId).then(
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
      await _getAllocatedRolePlayerCollectionRef(chapterMeetingId)
          .then((value) async {
        QuerySnapshot tempQS = await value
            .where("roleName", isEqualTo: roleName)
            .where("rolePlayerOrderPlace", isEqualTo: memberRolePlace)
            .get();

        if (tempQS.docs.isEmpty) {
          roleIsExisted = true;
        }
      });

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

  // @override
  // Future<Result<Unit, Failure>> allocateGuestNewRolePlayer(AllocatedRolePlayer allocatedRolePlayer) {
  //   // TODO: implement allocateGuestNewRolePlayer
  //   throw UnimplementedError();
  // }

  // @override
  // Future<Result<Unit, Failure>> allocateOtherClubMemberNewRolePlayer(String username) {
  //   // TODO: implement allocateOtherClubMemberNewRolePlayer
  //   throw UnimplementedError();
  // }

  // @override
  // Stream<List<AllocatedRolePlayer>> getAllAllocatedRolePlayers(String chapterMeetingId) {
  //   // TODO: implement getAllAllocatedRolePlayers
  //   throw UnimplementedError();
  // }

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

  Future<CollectionReference> _getAllocatedRolePlayerCollectionRef(
      String chapterMeetingId) async {
    CollectionReference allocatedRolePlayerCollection =
        FirebaseFirestore.instance.collection(" ");
    try {
      QuerySnapshot ChapterMeetingQS = await _chapterMeetingsCollection
          .where("chapterMeetingId", isEqualTo: chapterMeetingId)
          .get();
      if (ChapterMeetingQS.docs.isNotEmpty) {
        allocatedRolePlayerCollection = ChapterMeetingQS.docs.first.reference
            .collection("AllocatedRolePlayers");
      }
      return allocatedRolePlayerCollection;
    } catch (e) {
      return allocatedRolePlayerCollection;
    }
  }
}