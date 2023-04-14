import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:speaxpoint/services/failure.dart';
import 'package:speaxpoint/models/annoucement/volunteer_annoucement.dart';
import 'package:multiple_result/src/result.dart';
import 'package:speaxpoint/services/meeting_arrangement/common_services/meeting_arrangement_common_firebase_services.dart';
import 'package:speaxpoint/services/meeting_arrangement/manage_announcements/i_manage_chapter_meeting_announcements_service.dart';

class ManageChapterMeetingAnnouncementsFirebaseService
    extends MeetingArrangementCommonFirebaseServices
    implements IManageChapterMeeingAnnouncementsService {
  final CollectionReference _chapterMeetingsCollection =
      FirebaseFirestore.instance.collection('ChapterMeetings');
  @override
  Future<Result<VolunteerAnnouncement, Failure>> getVolunteersAnnouncement(
      {required String chapterMeetingId}) async {
    CollectionReference announcementCollection =
        FirebaseFirestore.instance.collection(" ");
    try {
      VolunteerAnnouncement volunteerAnnouncement = VolunteerAnnouncement(
        annoucementDate: null,
        annoucementDescription: null,
        annoucementStatus: null,
        annoucementTitle: null,
        annoucementType: null,
      );
      QuerySnapshot chapterMeetingQS = await _chapterMeetingsCollection
          .where("chapterMeetingId", isEqualTo: chapterMeetingId)
          .get();

      if (chapterMeetingQS.docs.isNotEmpty) {
        announcementCollection =
            chapterMeetingQS.docs.first.reference.collection("Announcements");
        var slotDR =
            await announcementCollection.doc("volunteersAnnouncement").get();

        if (slotDR.exists) {
          volunteerAnnouncement =  VolunteerAnnouncement.fromJson(
              slotDR.data() as Map<String, dynamic>);
        }
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
}
