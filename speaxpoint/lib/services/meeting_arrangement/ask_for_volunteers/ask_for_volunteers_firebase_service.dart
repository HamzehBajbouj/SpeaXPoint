import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:speaxpoint/services/Failure.dart';
import 'package:speaxpoint/models/volunteer_slot.dart';
import 'package:speaxpoint/models/annoucement/volunteer_annoucement.dart';
import 'package:multiple_result/src/unit.dart';
import 'package:multiple_result/src/result.dart';
import 'package:speaxpoint/services/meeting_arrangement/ask_for_volunteers/i_ask_for_volunteers_service.dart';
import 'package:speaxpoint/services/meeting_arrangement/common_services/meeting_arrangement_common_firebase_services.dart';

class AskForVolunteersFirebaseService
    extends MeetingArrangementCommonFirebaseServices
    implements IAskForVolunteersService {
  final CollectionReference _chapterMeetingsCollection =
      FirebaseFirestore.instance.collection('ChapterMeetings');

  @override
  Future<Result<Unit, Failure>> announceForVolunteers(
      {required String chapterMeetingId,
      required List<VolunteerSlot> volunteerSlots,
      required VolunteerAnnouncement announcement}) async {
    WriteBatch batch = FirebaseFirestore.instance.batch();
    CollectionReference volunteersSlotsCollection =
        FirebaseFirestore.instance.collection(" ");
    CollectionReference announcementsCollection =
        FirebaseFirestore.instance.collection(" ");
    try {
      QuerySnapshot chapterMeetingQS = await _chapterMeetingsCollection
          .where("chapterMeetingId", isEqualTo: chapterMeetingId)
          .get();

      if (chapterMeetingQS.docs.isNotEmpty) {
        volunteersSlotsCollection =
            chapterMeetingQS.docs.first.reference.collection("VolunteersSlots");
        QuerySnapshot slotQS = await volunteersSlotsCollection.get();

        //first empty the collection from all existing slots,
        //we need this to update the entire collection with the new data (from the one were existed)
        //before then fetched where some deleted and some are not
        //and from the newlly add slots
        for (var doc in slotQS.docs) {
          batch.delete(doc.reference);
        }

        int unquieID = 1;
        volunteerSlots.forEach(
          (element) {
            element.slotUnqiueId = unquieID;

            batch.set(
              volunteersSlotsCollection.doc(
                unquieID.toString(),
              ),
              element.toJson(),
            );
            unquieID++;
          },
        );

        await batch.commit().then(
          (_) {
            announcementsCollection = chapterMeetingQS.docs.first.reference
                .collection("Announcements");
            announcementsCollection.doc("volunteersAnnouncement").set(
                  announcement.toJson(),
                );
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
}
