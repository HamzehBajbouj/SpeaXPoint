import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/models/chapter_meeting.dart';
import 'package:speaxpoint/services/Failure.dart';

abstract class IManageComingSessionsService {
  Future<Result<Unit, Failure>> createNewSession(ChapterMeeting chapterMeeting);

//this one will get all the coming sessios that were created by the vice president of education
//it will use the toastmasterId to search for the coming sessions, the toastmasterId is the id
//for the one who created it
  Stream<List<ChapterMeeting>> getAllComingSessions();
}
