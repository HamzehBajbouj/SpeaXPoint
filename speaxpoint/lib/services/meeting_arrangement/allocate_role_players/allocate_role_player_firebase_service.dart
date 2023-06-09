import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:speaxpoint/models/allocated_role_player.dart';
import 'package:multiple_result/src/unit.dart';
import 'package:multiple_result/src/result.dart';
import 'package:speaxpoint/models/slot_applicant.dart';
import 'package:speaxpoint/models/toastmaster.dart';
import 'package:speaxpoint/services/meeting_arrangement/allocate_role_players/i_allocate_role_players_service.dart';
import 'package:speaxpoint/services/meeting_arrangement/common_services/meeting_arrangement_common_firebase_services.dart';
import 'package:speaxpoint/util/constants/common_enums.dart';
import '../../failure.dart';

class AllocateRolePlayerFirebaseService
    extends MeetingArrangementCommonFirebaseServices
    implements IAllocateRolePlayersService {
  final CollectionReference _chapterMeetingsCollection =
      FirebaseFirestore.instance.collection('ChapterMeetings');

  final CollectionReference _toastmasterCollection =
      FirebaseFirestore.instance.collection('Toastmasters');
//this collection serve as a quick serach and it also helps us when want to get
//the out-side users scheduled meeting with other clubs, please check the collection notes
  final CollectionReference _allocatedPlayersQuickSearchCollection =
      FirebaseFirestore.instance.collection('AllocatedPlayersQuickSearch');
  @override
  Future<Result<Unit, Failure>> allocateNewRolePlayer(String chapterMeetingId,
      AllocatedRolePlayer allocatedRolePlayer, bool deteleVolunteerSlot) async {
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
              .set(allocatedRolePlayer.toJson())
              .then(
            (_) async {
              //don't add it to allocatedPlayersQuickSearchCollection if it's a guest
              if (allocatedRolePlayer.allocatedRolePlayerType !=
                  AllocatedRolePlayerType.Guest.name) {
                //this will add a quick search data, read the file about AllocatedPlayersQuickSearch collection
                //to understand more about it.
                await _allocatedPlayersQuickSearchCollection.add(
                  {
                    'chapterMeetingId': chapterMeetingId,
                    'toastmasterId': allocatedRolePlayer.toastmasterId,
                    'allocatedRolePlayerType':
                        allocatedRolePlayer.allocatedRolePlayerType,
                    'roleName': allocatedRolePlayer.roleName,
                    'roleOrderPlace': allocatedRolePlayer.roleOrderPlace,
                  },
                );
              }

              /*
              this part to delete the role from the volunteers slots collection
              //in case it was announced the need for it but later the VPE, 
              added the role player from other options like (club members).

              the deteleVolunteerSlot is used to diffeneitate whether this serivce api
              was used from the volunteersTabview or not,
              becuase when we are accepting a volunteer applicant , we want to add
              him into the allocatedRolePlayer, but we also don't want to delete 
              the volunteerSlot in the collection if otherwise we will not be able 
              to see the accepted volunteers card in the volunteerTabView or other tabs
              */
              if (deteleVolunteerSlot) {
                super.getVolunteersSlotsCollectionRef(chapterMeetingId).then(
                  (collectionRef) async {
                    QuerySnapshot slotQS = await collectionRef
                        .where('roleName',
                            isEqualTo: allocatedRolePlayer.roleName)
                        .where('roleOrderPlace',
                            isEqualTo: allocatedRolePlayer.roleOrderPlace)
                        .get();
                    //first delete the subcollection , then delete the document
                    QuerySnapshot slotApplicantCollection = await slotQS
                        .docs.first.reference
                        .collection("SlotApplicants")
                        .get();
                    final List<Future<void>> futures = [];

                    for (DocumentSnapshot doc in slotApplicantCollection.docs) {
                      futures.add(doc.reference.delete());
                    }
                    await Future.wait(futures);
                    await slotQS.docs.first.reference.delete();
                  },
                );
              }
            },
          );
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

          if (allocatedRolePlayerQS.docs.isNotEmpty) {
            //delete the record in the AllocatedPlayersQuickSearchCollection
            Map<String, dynamic> temp =
                allocatedRolePlayerQS.docs.first.data() as Map<String, dynamic>;
            QuerySnapshot apqscQS = await _allocatedPlayersQuickSearchCollection
                .where('chapterMeetingId', isEqualTo: chapterMeetingId)
                .where('toastmasterId',
                    isEqualTo: temp['toastmasterId'].toString())
                .get();
            if (apqscQS.docs.isNotEmpty) {
              await apqscQS.docs.first.reference.delete();
            }
            //then delete the record in the allocatedRolePlayer collection
            await allocatedRolePlayerQS.docs.first.reference.delete();
          }
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

            //also update in the _allocatedPlayersQuickSearchCollection
            QuerySnapshot quickSearchCollectionSQ =
                await _allocatedPlayersQuickSearchCollection
                    .where('chapterMeetingId', isEqualTo: chapterMeetingId)
                    .where("roleName", isEqualTo: allocatedRolePlayer.roleName)
                    .where("roleOrderPlace",
                        isEqualTo: allocatedRolePlayer.roleOrderPlace)
                    .get();
            if (quickSearchCollectionSQ.docs.isNotEmpty) {
              await quickSearchCollectionSQ.docs.first.reference.update(
                {
                  'toastmasterId': allocatedRolePlayer.toastmasterId,
                  'allocatedRolePlayerType':
                      allocatedRolePlayer.allocatedRolePlayerType,
                },
              );
            }
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
  //it can become a genetic to reduce the code depulications since almost the same method
  //is used in differnet loation
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

  @override
  Future<Result<Unit, Failure>> deleteAnnouncedVolunteerSlot({
    required String chapterMeetingId,
    required int volunteerSlotId,
    required String roleName,
    required int roleOderPlace,
  }) async {
    try {
      //delte if first in the volunteersSlot collection
      await super.getVolunteersSlotsCollectionRef(chapterMeetingId).then(
        (collectionRef) async {
          QuerySnapshot slotQS = await collectionRef
              .where("slotUnqiueId", isEqualTo: volunteerSlotId)
              .get();

          if (slotQS.docs.isNotEmpty) {
            QuerySnapshot slotApplicantCollection = await slotQS
                .docs.first.reference
                .collection("SlotApplicants")
                .get();
            final List<Future<void>> futures = [];

            for (DocumentSnapshot doc in slotApplicantCollection.docs) {
              futures.add(doc.reference.delete());
            }
            await Future.wait(futures);
            await slotQS.docs.first.reference.delete();
          } else {
            return Error(
              Failure(
                  code: "no-volunteer-slot-found",
                  location:
                      "AllocateRolePlayerFirebaseService.deleteAnnouncedVolunteerSlot()",
                  message:
                      "could not find the volunteer slot with Id : $volunteerSlotId"),
            );
          }
        },
      );
      //in case that there was an accepted applicant, then this applicant details
      //are now in the allocaedRolePlayers collection we need to delete it there as well.
      //we also need to delete it from the _allocatedPlayersQuickSearchCollection
      await super.getAllocatedRolePlayerCollectionRef(chapterMeetingId).then(
        (collectionRef) async {
          QuerySnapshot allocatedRoleQS = await collectionRef
              .where("roleName", isEqualTo: roleName)
              .where("roleOrderPlace", isEqualTo: roleOderPlace)
              .get();
          if (allocatedRoleQS.docs.isNotEmpty) {
            await allocatedRoleQS.docs.first.reference.delete();
          }
        },
      );
      //delete it from the AllocatedPlayersQuickSearchCollection
      QuerySnapshot quickSearchCollectionSQ =
          await _allocatedPlayersQuickSearchCollection
              .where('chapterMeetingId', isEqualTo: chapterMeetingId)
              .where("roleName", isEqualTo: roleName)
              .where("roleOrderPlace", isEqualTo: roleOderPlace)
              .get();
      if (quickSearchCollectionSQ.docs.isNotEmpty) {
        await quickSearchCollectionSQ.docs.first.reference.delete();
      }

      return Success.unit();
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location:
                "AllocateRolePlayerFirebaseService.deleteAnnouncedVolunteerSlot()",
            message: e.message ??
                "Database Error While deleting volunteer slot with Id : $volunteerSlotId"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location:
                "AllocateRolePlayerFirebaseService.deleteAnnouncedVolunteerSlot()",
            message: e.toString()),
      );
    }
  }

  @override
  Future<Result<List<Toastmaster>, Failure>>
      getListOfAllVolunteerSlotApplicants(
          {required String chapterMeetingId,
          required int volunteerSlotId}) async {
    final CollectionReference toastmastersCollection =
        FirebaseFirestore.instance.collection('Toastmasters');
    List<Toastmaster> toastmasterApplicants = [];

    try {
      //delte if first in the volunteersSlot collection
      await super.getVolunteersSlotsCollectionRef(chapterMeetingId).then(
        (collectionRef) async {
          QuerySnapshot slotQS = await collectionRef
              .where("slotUnqiueId", isEqualTo: volunteerSlotId)
              .get();

          if (slotQS.docs.isNotEmpty) {
            //to get the list of applicant docs
            QuerySnapshot applicantQS = await slotQS.docs.first.reference
                .collection("SlotApplicants")
                .get();

            for (var doc in applicantQS.docs) {
              String toastmasterId = doc["toastmasterId"] as String;
              QuerySnapshot toastmasterQS = await toastmastersCollection
                  .where("toastmasterId", isEqualTo: toastmasterId)
                  .get();
              if (toastmasterQS.docs.isNotEmpty) {
                toastmasterApplicants.add(
                  Toastmaster.fromJson(
                      toastmasterQS.docs.first.data() as Map<String, dynamic>),
                );
              }
            }
          } else {
            return Error(
              Failure(
                  code: "no-volunteer-slot-found",
                  location:
                      "AllocateRolePlayerFirebaseService.getListOfAllVolunteerSlotApplicants()",
                  message:
                      "could not find the volunteer slot with Id : $volunteerSlotId"),
            );
          }
        },
      );

      return Success(toastmasterApplicants);
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location:
                "AllocateRolePlayerFirebaseService.getListOfAllVolunteerSlotApplicants()",
            message: e.message ??
                "Database Error While getting volunteer slot applicants list with Id : $volunteerSlotId"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location:
                "AllocateRolePlayerFirebaseService.getListOfAllVolunteerSlotApplicants()",
            message: e.toString()),
      );
    }
  }

  @override
  Future<Result<Unit, Failure>> acceptVolunteerSlotApplicant(
      {required String chapterMeetingId,
      required int volunteerSlotId,
      required SlotApplicant slotApplicant}) async {
    try {
      //delte if first in the volunteersSlot collection
      await super.getVolunteersSlotsCollectionRef(chapterMeetingId).then(
        (collectionRef) async {
          QuerySnapshot slotQS = await collectionRef
              .where("slotUnqiueId", isEqualTo: volunteerSlotId)
              .get();

          if (slotQS.docs.isNotEmpty) {
            //to get the list of applicant docs
            await slotQS.docs.first.reference.update({
              'slotStatus': VolunteerSlotStatus.AcceptedApplication.name
            }).then(
              (_) async {
                QuerySnapshot applicantQS = await slotQS.docs.first.reference
                    .collection("SlotApplicants")
                    .where("toastmasterId",
                        isEqualTo: slotApplicant.toastmasterId)
                    .get();
                await applicantQS.docs.first.reference.update(
                  {
                    'applicantStatus': slotApplicant.applicantStatus,
                    'acceptanceDate': slotApplicant.acceptanceDate
                  },
                );
              },
            );
          } else {
            return Error(
              Failure(
                  code: "no-volunteer-slot-found",
                  location:
                      "AllocateRolePlayerFirebaseService.getListOfAllVolunteerSlotApplicants()",
                  message:
                      "could not find the volunteer slot with Id : $volunteerSlotId"),
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
                "AllocateRolePlayerFirebaseService.acceptVolunteerSlotApplicant()",
            message: e.message ??
                "Database Error While accepting volunteer slot applicants list with Id : $volunteerSlotId"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location:
                "AllocateRolePlayerFirebaseService.acceptVolunteerSlotApplicant()",
            message: e.toString()),
      );
    }
  }

  @override
  Future<Result<Toastmaster, Failure>> getAcceptedVolunteerDetails(
      {required String chapterMeetingId, required int volunteerSlotId}) async {
    final CollectionReference toastmastersCollection =
        FirebaseFirestore.instance.collection('Toastmasters');
    Toastmaster toastmasterApplicant = Toastmaster();

    try {
      await super.getVolunteersSlotsCollectionRef(chapterMeetingId).then(
        (collectionRef) async {
          QuerySnapshot slotQS = await collectionRef
              .where("slotUnqiueId", isEqualTo: volunteerSlotId)
              .get();
          if (slotQS.docs.isNotEmpty) {
            QuerySnapshot applicantQS = await slotQS.docs.first.reference
                .collection("SlotApplicants")
                .where("applicantStatus", isEqualTo: "Accepted")
                .get();
            if (applicantQS.docs.isNotEmpty) {
              String toastmasterId =
                  applicantQS.docs.first["toastmasterId"] as String;
              QuerySnapshot toastmasterQS = await toastmastersCollection
                  .where("toastmasterId", isEqualTo: toastmasterId)
                  .get();
              if (toastmasterQS.docs.isNotEmpty) {
                toastmasterApplicant = Toastmaster.fromJson(
                    toastmasterQS.docs.first.data() as Map<String, dynamic>);
              }
            }
          } else {
            return Error(
              Failure(
                  code: "no-volunteer-slot-found",
                  location:
                      "AllocateRolePlayerFirebaseService.getAcceptedVolunteerDetails()",
                  message:
                      "could not find the volunteer slot with Id : $volunteerSlotId"),
            );
          }
        },
      );

      return Success(toastmasterApplicant);
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location:
                "AllocateRolePlayerFirebaseService.getAcceptedVolunteerDetails()",
            message: e.message ??
                "Database Error While getting accepted volunteer applicants details for slot with Id : $volunteerSlotId"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location:
                "AllocateRolePlayerFirebaseService.getAcceptedVolunteerDetails()",
            message: e.toString()),
      );
    }
  }

  @override
  Future<Result<Unit, Failure>> allocateChapterMeetingVisitor(
      {required String chapterMeetingId,
      required String clubId,
      required AllocatedRolePlayer allocatedRolePlayer}) async {
    try {
      QuerySnapshot chapterMeetingsQS = await _chapterMeetingsCollection
          .where("clubId", isEqualTo: clubId)
          .where("chapterMeetingId", isEqualTo: chapterMeetingId)
          .get();
      if (chapterMeetingsQS.docs.isNotEmpty) {
        CollectionReference allocatedRolePlayersC = chapterMeetingsQS
            .docs.first.reference
            .collection("AllocatedRolePlayers");

        QuerySnapshot allocatedRolePlayerQS;
        //check first if the meeting visitor is already there or not
        allocatedRolePlayerQS = await allocatedRolePlayersC
            .where("toastmasterId",
                isEqualTo: allocatedRolePlayer.toastmasterId)
            .get();

        if (allocatedRolePlayerQS.docs.isNotEmpty) {
          return const Error(
            Failure(
                code: "Meeting-Visitor-Id-Is-Existed",
                location:
                    "AllocateRolePlayerFirebaseService.allocateChapterMeetingVisitor()",
                message:
                    "You have previously joined/added to this chapter meeting session."),
          );
        } else {
          allocatedRolePlayerQS = await allocatedRolePlayersC.get();

          //this list is need to obtains the latest unique id number
          List<AllocatedRolePlayer> allocatedRolePlayerList =
              allocatedRolePlayerQS.docs
                  .map((e) => AllocatedRolePlayer.fromJson(
                      e.data() as Map<String, dynamic>))
                  .toList();

          int uniqueId = _getlNewtUniqueIdNumber(allocatedRolePlayerList);
          allocatedRolePlayer.allocatedRolePlayerUniqueId = uniqueId;

          allocatedRolePlayersC
              .doc(uniqueId.toString())
              .set(allocatedRolePlayer.toJson())
              .then(
            (_) async {
              //don't add it to allocatedPlayersQuickSearchCollection if it's a guest
              if (allocatedRolePlayer.allocatedRolePlayerType !=
                  AllocatedRolePlayerType.Guest.name) {
                //this will add a quick search data, read the file about AllocatedPlayersQuickSearch collection
                //to understand more about it.
                await _allocatedPlayersQuickSearchCollection.add(
                  {
                    'chapterMeetingId': chapterMeetingId,
                    'toastmasterId': allocatedRolePlayer.toastmasterId,
                    'allocatedRolePlayerType':
                        allocatedRolePlayer.allocatedRolePlayerType,
                    'roleName': allocatedRolePlayer.roleName,
                    'roleOrderPlace': allocatedRolePlayer.roleOrderPlace,
                  },
                );
              }
            },
          );
        }
      } else {
        return Error(
          Failure(
              code: "No-Chapter-Meeting-Found",
              location:
                  "AllocateRolePlayerFirebaseService.allocateChapterMeetingVisitor()",
              message:
                  "Could not find any chapter meeting with Id : $chapterMeetingId"),
        );
      }
      return Success.unit();
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location:
                "AllocateRolePlayerFirebaseService.allocateChapterMeetingVisitor()",
            message: e.message ?? "Database Error While adding MeetingVisitor"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location:
                "AllocateRolePlayerFirebaseService.allocateChapterMeetingVisitor()",
            message: e.toString()),
      );
    }
  }
}
