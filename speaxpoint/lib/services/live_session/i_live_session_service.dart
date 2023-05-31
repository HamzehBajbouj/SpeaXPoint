import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/models/evaluation_note.dart';
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
    String? chapterMeetingInvitationCode,
  });

  Stream<List<OnlineSessionCapturedData>> getListOfSpeachesForAppUser({
    required String chapterMeetingId,
  });

  Stream<List<OnlineSessionCapturedData>> getListOfSpeachesForAppGuest({
    required String chapterMeetingInvitationCode,
    required String guestInvitationCode,
  });

  Future<Result<Unit, Failure>> addGeneralEvaluationNoteAppUser({
    required String chapterMeetingId,
    required String toastmasterId,
    required EvaluationNote evaluationNote,
  });

  Future<Result<Unit, Failure>> deleteGeneralEvaluationNoteAppUser({
    required String chapterMeetingId,
    required String toastmasterId,
    required String noteId,
  });

  Stream<List<EvaluationNote>> getGeneralEvaluationNoteAppUser({
    required String chapterMeetingId,
    required String toastmasterId,
  });

  Future<Result<Unit, Failure>> addGeneralEvaluationNoteGuestUser({
    required String guestInvitationCode,
    required String chapterMeetingInvitationCode,
    required EvaluationNote evaluationNote,
  });
  Future<Result<Unit, Failure>> deleteGeneralEvaluationNoteGuestUser({
    required String guestInvitationCode,
    required String chapterMeetingInvitationCode,
    required String noteId,
  });

  Stream<List<EvaluationNote>> getGeneralEvaluationNoteGuestUser({
    required String guestInvitationCode,
    required String chapterMeetingInvitationCode,
  });
}
