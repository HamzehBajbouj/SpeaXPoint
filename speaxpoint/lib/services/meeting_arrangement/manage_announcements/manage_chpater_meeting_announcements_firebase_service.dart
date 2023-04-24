import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multiple_result/src/unit.dart';
import 'package:speaxpoint/services/failure.dart';
import 'package:speaxpoint/models/annoucement/volunteer_annoucement.dart';
import 'package:multiple_result/src/result.dart';
import 'package:speaxpoint/services/meeting_arrangement/common_services/meeting_arrangement_common_firebase_services.dart';
import 'package:speaxpoint/services/meeting_arrangement/manage_announcements/i_manage_chapter_meeting_announcements_service.dart';
import 'package:speaxpoint/util/constants/common_enums.dart';

class ManageChapterMeetingAnnouncementsFirebaseService
    extends MeetingArrangementCommonFirebaseServices
    implements IManageChapterMeeingAnnouncementsService {
  final CollectionReference _announcementCollection =
      FirebaseFirestore.instance.collection("Announcements");
  @override
  Future<Result<VolunteerAnnouncement, Failure>> getVolunteersAnnouncement(
      {required String chapterMeetingId}) async {
    try {
      VolunteerAnnouncement volunteerAnnouncement = VolunteerAnnouncement(
        annoucementDate: null,
        annoucementDescription: null,
        annoucementStatus: null,
        annoucementTitle: null,
        annoucementType: null,
      );
      QuerySnapshot announcementQS = await _announcementCollection
          .where("chapterMeetingId", isEqualTo: chapterMeetingId)
          .where("annoucementType",
              isEqualTo: AnnouncementType.VolunteersAnnouncement.name)
          .get();

      if (announcementQS.docs.isNotEmpty) {
        volunteerAnnouncement = VolunteerAnnouncement.fromJson(
            announcementQS.docs.first.data() as Map<String, dynamic>);
      } else {
        return const Error(
          Failure(
              code: 'no-chapter-meeting-is-found',
              location:
                  "ManageChapterMeetingAnnouncementsFirebaseService.getVolunteersAnnouncement()",
              message:
                  "It seems the app can't find the chapter meeting record in the databases."),
        );
      }
      return Success(volunteerAnnouncement);
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location:
                "ManageChapterMeetingAnnouncementsFirebaseService.getVolunteersAnnouncement()",
            message: e.message ??
                "Database Error While fetching volunteers announcement details"),
      );
    } catch (e) {
      return Error(
        Failure(
          code: e.toString(),
          location:
              "ManageChapterMeetingAnnouncementsFirebaseService.getVolunteersAnnouncement()",
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Stream<List<Map<String, dynamic>>> getChapterMeetingAnnouncement(
      {required String chapterMeetingId}) async* {
    Stream<List<Map<String, dynamic>>> announcements = Stream.empty();
    try {
      var announcementgQS = _announcementCollection
          .where("chapterMeetingId", isEqualTo: chapterMeetingId)
          .snapshots();
      announcements = announcementgQS.map(
        (QuerySnapshot querySnapshot) => querySnapshot.docs
            .map(
              (e) => e.data() as Map<String, dynamic>,
            )
            .toList(),
      );

      yield* announcements;
    } on FirebaseException catch (e) {
      log("${e.code} ${e.message}");
      yield* announcements;
    } catch (e) {
      log(e.toString());
      yield* announcements;
    }
  }

  @override
  Future<Result<Unit, Failure>> deletePublishedAnnouncement(
      {required String chapterMeetingId,
      required String announcementType}) async {
    try {
      QuerySnapshot announcementQS = await _announcementCollection
          .where("chapterMeetingId", isEqualTo: chapterMeetingId)
          .where("annoucementType", isEqualTo: announcementType)
          .get();

      if (announcementQS.docs.isNotEmpty) {
        await announcementQS.docs.first.reference.delete();
      } else {
        return Error(
          Failure(
              code: 'No-Announcement-Found',
              location:
                  "ManageChapterMeetingAnnouncementsFirebaseService.deletePublishedAnnouncement()",
              message:
                  "It seems there is no annoucement record for $announcementType in the databases."),
        );
      }
      return Success.unit();
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location:
                "ManageChapterMeetingAnnouncementsFirebaseService.deletePublishedAnnouncement()",
            message:
                e.message ?? "Database Error While deleting the announcement"),
      );
    } catch (e) {
      return Error(
        Failure(
          code: e.toString(),
          location:
              "ManageChapterMeetingAnnouncementsFirebaseService.deletePublishedAnnouncement()",
          message: e.toString(),
        ),
      );
    }
  }
}
