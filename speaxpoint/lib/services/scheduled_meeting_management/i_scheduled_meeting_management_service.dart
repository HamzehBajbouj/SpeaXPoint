import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/models/chapter_meeting.dart';
import 'package:speaxpoint/services/failure.dart';

abstract class IScheduledMeetingManagementService {
   Future<Result<List<ChapterMeeting>, Failure>> getAllScheduledMeeting({
    required String clubId,
    required String toastmasterId,
  });
}
