import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/models/annoucement/volunteer_annoucement.dart';
import 'package:speaxpoint/services/failure.dart';
import 'package:speaxpoint/services/meeting_arrangement/common_services/i_meeting_arrangement_common_services.dart';

abstract class IManageChapterMeeingAnnouncementsService
    extends IMeetingArrangementCommonServices {
  Future<Result<VolunteerAnnouncement, Failure>> getVolunteersAnnouncement(
      {required String chapterMeetingId});

  Future<Result<Unit, Failure>> deletePublishedAnnouncement(
      {required String chapterMeetingId, required String announcementType});

  Stream<List<Map<String, dynamic>>> getChapterMeetingAnnouncement(
      {required String chapterMeetingId});
}
