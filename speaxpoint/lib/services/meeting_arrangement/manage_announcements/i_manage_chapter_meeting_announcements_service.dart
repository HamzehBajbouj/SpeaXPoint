import 'dart:io';

import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/models/annoucement/announcement.dart';
import 'package:speaxpoint/models/annoucement/chapter_meeting_announcement.dart';
import 'package:speaxpoint/services/failure.dart';
import 'package:speaxpoint/services/meeting_arrangement/common_services/i_meeting_arrangement_common_services.dart';

abstract class IManageChapterMeeingAnnouncementsService
    extends IMeetingArrangementCommonServices {
  //to get only volunteer query announcement
  Future<Result<Announcement, Failure>> getVolunteersAnnouncement(
      {required String chapterMeetingId});
//to get only chapter meeting announcement
  Future<Result<ChapterMeetingAnnouncement, Failure>> getChapterMeetingAnnouncement(
      {required String chapterMeetingId});

  Future<Result<Unit, Failure>> deletePublishedAnnouncement(
      {required String chapterMeetingId, required String announcementType});

//to get all announcement despite of thier types
  Stream<List<Map<String, dynamic>>> getAllChapterMeetingAnnouncements(
      {required String chapterMeetingId});
  Future<Result<Unit, Failure>> announceChapterMeeting({
    required ChapterMeetingAnnouncement chapterMeetingAnnouncement,
    required File? brochureFile,
    required String chapterMeetingId,
  });
}
