import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/models/online_session_captured_data.dart';

import '../failure.dart';

abstract class ILiveSessionService {
  /*
  This part is related to the Manage Role Players
  */

  Future<Result<String, Failure>> getSessionLaunchingTime({
    required String chapterMeetingId,
  });

  Stream<int> getNumberOfOnlinePeople({
    required String chapterMeetingId,
  });

  Future<Result<Unit, Failure>> endChapterMeetingSession({
    required String chapterMeetingId,
  });

  Future<Result<Unit, Failure>> selectSpeech({
    required String chapterMeetingId,
    required bool isAnAppGuest,
    String? toastmasterId,
    String? guestInvitationCode,
    String ? chapterMeetingInvitationCode,
  });

  Stream<List<OnlineSessionCapturedData>> getOnlineCapturedDataForAppUser({
    required String chapterMeetingId,
  });

  Stream<List<OnlineSessionCapturedData>> getOnlineCapturedDataForAppGuest({
    required String chapterMeetingInvitationCode,
    required String guestInvitationCode,
  });
}