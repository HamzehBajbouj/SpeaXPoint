import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/models/online_session.dart';
import 'package:speaxpoint/models/online_session_captured_data.dart';

import '../failure.dart';

abstract class ILiveSessionService {
  /*
  This part is related to the Manage Role Players
  */

  Future<Result<String, Failure>> getSessionLaunchingTime({
        required bool isAnAppGuest,
     String? chapterMeetingId,
       String? chapterMeetingInvitationCode,
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
    String? chapterMeetingInvitationCode,
  });

  Stream<List<OnlineSessionCapturedData>> getListOfSpeachesForAppUser({
    required String chapterMeetingId,
  });

  Stream<List<OnlineSessionCapturedData>> getListOfSpeachesForAppGuest({
    required String chapterMeetingInvitationCode,
  });

  /*
    These are common services that used accross the screens.
  */
  Stream<OnlineSession> getOnlineSessionDetails({
    //isAnAppGuest refers to the currently app users whether he is an app user or just
    //logging as a guest
    required bool isAnAppGuest,
    String? chapterMeetingId,
    String? chapterMeetingInvitationCode,
  });

  Future<Result<List<OnlineSessionCapturedData>, Failure>>
      getListOfSpeachesSpeakersForAppUser({
    required String chapterMeetingId,
  });

  Future<Result<List<OnlineSessionCapturedData>, Failure>>
      getListOfSpeachesSpeakersForAppGuest({
    required String chapterMeetingInvitationCode,
    required String guestInvitationCode,
  });
}
