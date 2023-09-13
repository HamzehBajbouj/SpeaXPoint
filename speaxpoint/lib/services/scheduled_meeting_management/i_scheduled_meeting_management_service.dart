import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/models/chapter_meeting.dart';
import 'package:speaxpoint/services/failure.dart';

abstract class IScheduledMeetingManagementService {
  Future<Result<List<ChapterMeeting>, Failure>> getAllScheduledMeeting({
    required String clubId,
    required String toastmasterId,
  });

  Future<Result<Unit, Failure>> lanuchChapterMeetingSessions(
      {required String chapterMeetingId});

//these two method are mean in the first palce to increase the online people counter
  Future<Result<Unit, Failure>> joinChapterMeetingSessionAppUser({
    required String chapterMeetingId,
  });
  Future<Result<Unit, Failure>> joinChapterMeetingSessionGuestUser({
    required String chapterMeetingInvitationCode,
  });
}
