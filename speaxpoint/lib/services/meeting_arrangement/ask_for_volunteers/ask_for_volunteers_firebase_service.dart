import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:speaxpoint/models/annoucement/announcement.dart';
import 'package:speaxpoint/models/slot_applicant.dart';
import 'package:speaxpoint/services/failure.dart';
import 'package:speaxpoint/models/volunteer_slot.dart';
import 'package:multiple_result/src/unit.dart';
import 'package:multiple_result/src/result.dart';
import 'package:speaxpoint/services/meeting_arrangement/ask_for_volunteers/i_ask_for_volunteers_service.dart';
import 'package:speaxpoint/services/meeting_arrangement/common_services/meeting_arrangement_common_firebase_services.dart';
import 'package:speaxpoint/util/constants/common_enums.dart';

class AskForVolunteersFirebaseService
    extends MeetingArrangementCommonFirebaseServices
    implements IAskForVolunteersService {
  final CollectionReference _chapterMeetingsCollection =
      FirebaseFirestore.instance.collection('ChapterMeetings');

  @override
  Future<Result<Unit, Failure>> announceForVolunteers(
      {required String chapterMeetingId,
      required List<VolunteerSlot> volunteerSlots,
      required Announcement announcement}) async {
    WriteBatch batch = FirebaseFirestore.instance.batch();
    CollectionReference volunteersSlotsCollection =
        FirebaseFirestore.instance.collection(" ");
    CollectionReference announcementsCollection =
        FirebaseFirestore.instance.collection("Announcements");
    try {
      QuerySnapshot chapterMeetingQS = await _chapterMeetingsCollection
          .where("chapterMeetingId", isEqualTo: chapterMeetingId)
          .get();

      if (chapterMeetingQS.docs.isNotEmpty) {
        volunteersSlotsCollection =
            chapterMeetingQS.docs.first.reference.collection("VolunteersSlots");
        QuerySnapshot slotQS = await volunteersSlotsCollection.get();

        /*

        first empty the collection from all existing slots,
        we need this to update the entire collection with the new data (from the one were existed)
        before then fetched where some deleted and some are not
        and from the newlly add slots
        we need this in case the new announcement has less slots than the previous
        meaning the VPE deleted/excluded some slots in the Ask for Volunteers Page
        
      the app will check from the coming volunteerSlots, AND the once that are coming
      from the screen (ask for volunteers).
      then it will delete from the VolunteersSlots collection every elemenet that 
      is in the VolunteersSlots firestore collection  but not in the screen list.

      then i will delete all the slots that are in  VolunteersSlots collection but 
      in the screen there is state is unAnnounced.
      then after emptying the deleting the docuements in the collection
      we will set all the slots we got from the screen that their state is un-anounced
      */

        for (var doc in slotQS.docs) {
          VolunteerSlot tempSlot =
              VolunteerSlot.fromJson(doc.data() as Map<String, dynamic>);
          //chek
          bool slotIsExisted = volunteerSlots.any((element) =>
              element.roleName == tempSlot.roleName &&
              element.roleOrderPlace == tempSlot.roleOrderPlace);
          if (!slotIsExisted) {
            //if you didn't find the one that fetched from the firestore , in the list
            //of the slots that are fetched from the screen, immeditally delete
            //as the VPE has deleted some slots in the ask for volunteers screen
            batch.delete(doc.reference);
          } else {
            //now check in the list that is passed from the ask for volunteer screen
            //to exclude the elements that have been announced previouslly
            //so we don't delete them and then create a new instance.
            //it will chek from the un-announced slots from the screen
            //if it found a match then return true
            bool slotIsNotAnnounced = volunteerSlots.any((element) =>
                element.roleName == tempSlot.roleName &&
                element.roleOrderPlace == tempSlot.roleOrderPlace &&
                element.isItAnnouncedBefore !=
                    AppVolunteerSlotStatus.Announced.name);
            if (slotIsNotAnnounced) {
              batch.delete(doc.reference);
            }
          }
        }

        //to get the biggest unqiue id and starting from there we will increment
        int unquieID = _getlNewtUniqueIdNumber(volunteerSlots);
        //set only the once that have not been announced
        volunteerSlots.forEach(
          (element) {
            if (element.isItAnnouncedBefore !=
                AppVolunteerSlotStatus.Announced.name) {
              element.slotUnqiueId = unquieID;
              batch.set(
                volunteersSlotsCollection.doc(
                  unquieID.toString(),
                ),
                element.toJson(),
              );
              unquieID++;
            }
          },
        );

        await batch.commit().then(
          (_) async {
            QuerySnapshot announcementQS = await announcementsCollection
                .where("chapterMeetingId", isEqualTo: chapterMeetingId)
                .where('annoucementType',
                    isEqualTo: AnnouncementType.VolunteersAnnouncement.name)
                .get();
            if (announcementQS.docs.isNotEmpty) {
              await announcementQS.docs.first.reference.set(
                announcement.toJson(),
              );
            } else {
              await announcementsCollection.add(announcement.toJson());
            }
          },
        );
      } else {
        return const Error(
          Failure(
              code: 'no-chapter-meeting-is-found',
              location:
                  "AskForVolunteersFirebaseService.announceForVolunteers()",
              message:
                  "It seems the app can't find the chapter meeting record in the databases."),
        );
      }
      return Success.unit();
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location: "AskForVolunteersFirebaseService.announceForVolunteers()",
            message: e.message ??
                "Database Error While annoucing asking for volunteers"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location: "AskForVolunteersFirebaseService.announceForVolunteers()",
            message: e.toString()),
      );
    }
  }

  @override
  Future<Result<List<VolunteerSlot>, Failure>> getVolunteersAnnouncedSlot({
    required String chapterMeetingId,
  }) async {
    List<VolunteerSlot> slots = [];

    CollectionReference volunteersSlotsCollection =
        FirebaseFirestore.instance.collection(" ");
    try {
      QuerySnapshot chapterMeetingQS = await _chapterMeetingsCollection
          .where("chapterMeetingId", isEqualTo: chapterMeetingId)
          .get();

      if (chapterMeetingQS.docs.isNotEmpty) {
        volunteersSlotsCollection =
            chapterMeetingQS.docs.first.reference.collection("VolunteersSlots");
        QuerySnapshot slotQS = await volunteersSlotsCollection.get();
        slots = slotQS.docs
            .map(
              (e) => VolunteerSlot.fromJson(e.data() as Map<String, dynamic>),
            )
            .toList();
      } else {
        return const Error(
          Failure(
              code: 'no-chapter-meeting-is-found',
              location:
                  "AskForVolunteersFirebaseService.getVolunteersAnnouncedSlot()",
              message:
                  "It seems the app can't find the chapter meeting record in the databases."),
        );
      }
      return Success(slots);
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location:
                "AskForVolunteersFirebaseService.getVolunteersAnnouncedSlot()",
            message: e.message ??
                "Database Error While fetching volunteers slots from the database"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location:
                "AskForVolunteersFirebaseService.getVolunteersAnnouncedSlot()",
            message: e.toString()),
      );
    }
  }

  int _getlNewtUniqueIdNumber(List<VolunteerSlot> list) {
    int biggestAgendaCardNumber = 0;

    if (list.isNotEmpty) {
      return biggestAgendaCardNumber = list.fold(
            biggestAgendaCardNumber,
            (previousValue, element) =>
                max(previousValue, element.slotUnqiueId!),
          ) +
          1;
    } else {
      return biggestAgendaCardNumber += biggestAgendaCardNumber + 1;
    }
  }

  @override
  Future<Result<bool, Failure>> checkExistingSlotApplicant(
      {required int slotUnqiueId,
      required String chapterMeetingId,
      required String toastmasterId}) async {
    //true if the applicant is existed
    bool volunteerIsExisted = false;

    try {
      QuerySnapshot chapterMeetingQS = await _chapterMeetingsCollection
          .where("chapterMeetingId", isEqualTo: chapterMeetingId)
          .get();

      if (chapterMeetingQS.docs.isNotEmpty) {
        CollectionReference volunteersSlotsCollection =
            chapterMeetingQS.docs.first.reference.collection("VolunteersSlots");
        QuerySnapshot slotQS = await volunteersSlotsCollection
            .where("slotUnqiueId", isEqualTo: slotUnqiueId)
            .get();

        if (slotQS.docs.isEmpty) {
          return Error(
            Failure(
                code: 'no-volunteer-slot-is-found',
                location:
                    "AskForVolunteersFirebaseService.checkExistingSlotApplicant()",
                message:
                    "It seems the app can't find the volunteer slot record with Id $slotUnqiueId in the databases."),
          );
        } else {
          CollectionReference slotApplicantCollection =
              slotQS.docs.first.reference.collection("SlotApplicants");
          QuerySnapshot slotApplicantQS = await slotApplicantCollection
              .where("toastmasterId", isEqualTo: toastmasterId)
              .get();
          if (slotApplicantQS.docs.isEmpty) {
            volunteerIsExisted = false;
          } else {
            volunteerIsExisted = true;
          }
        }
      } else {
        return const Error(
          Failure(
              code: 'no-chapter-meeting-is-found',
              location:
                  "AskForVolunteersFirebaseService.checkExistingSlotApplicant()",
              message:
                  "It seems the app can't find the chapter meeting record in the databases."),
        );
      }
      return Success(volunteerIsExisted);
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location:
                "AskForVolunteersFirebaseService.checkExistingSlotApplicant()",
            message: e.message ??
                "Database Error While checking volunteers slots applicants from the database"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location:
                "AskForVolunteersFirebaseService.checkExistingSlotApplicant()",
            message: e.toString()),
      );
    }
  }

  @override
  Future<Result<Unit, Failure>> addNewVolunteerSlotApplicant(
      {required int slotUnqiueId,
      required String chapterMeetingId,
      required SlotApplicant slotApplicant}) async {
    try {
      QuerySnapshot chapterMeetingQS = await _chapterMeetingsCollection
          .where("chapterMeetingId", isEqualTo: chapterMeetingId)
          .get();

      if (chapterMeetingQS.docs.isNotEmpty) {
        CollectionReference volunteersSlotsCollection =
            chapterMeetingQS.docs.first.reference.collection("VolunteersSlots");
        QuerySnapshot slotQS = await volunteersSlotsCollection
            .where("slotUnqiueId", isEqualTo: slotUnqiueId)
            .get();

        if (slotQS.docs.isEmpty) {
          return Error(
            Failure(
                code: 'no-volunteer-slot-is-found',
                location:
                    "AskForVolunteersFirebaseService.addNewVolunteerSlotApplicant()",
                message:
                    "It seems the app can't find the volunteer slot record with Id $slotUnqiueId in the databases."),
          );
        } else {
          await slotQS.docs.first.reference.update(
              {'slotStatus': VolunteerSlotStatus.PendingApplication.name}).then(
            (value) async {
              await slotQS.docs.first.reference
                  .collection("SlotApplicants")
                  .add(slotApplicant.toJson());
            },
          );
        }
      } else {
        return const Error(
          Failure(
              code: 'no-chapter-meeting-is-found',
              location:
                  "AskForVolunteersFirebaseService.addNewVolunteerSlotApplicant()",
              message:
                  "It seems the app can't find the chapter meeting record in the databases."),
        );
      }
      return Success.unit();
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location:
                "AskForVolunteersFirebaseService.addNewVolunteerSlotApplicant()",
            message: e.message ??
                "Database Error While adding a new volunteers slots applicant to the database"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location:
                "AskForVolunteersFirebaseService.addNewVolunteerSlotApplicant()",
            message: e.toString()),
      );
    }
  }
}
