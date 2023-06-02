import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/models/evaluation_notes/evaluation_note.dart';
import 'package:speaxpoint/models/evaluation_notes/temp_evaluation_note.dart';
import 'package:speaxpoint/models/online_session.dart';
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
  });
  /*
    This part is for general Evaluator use case.
  */

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

  /*
    This part is for Speech Evaluation
  */
  Future<Result<Unit, Failure>> addSpeechEvaluationNote({
    required TempSpeechEvaluationNote evaluationNote,
  });
  /*
  This method is used to delete the evaluation notes that has been evaluated
  for a specfic speakers (regardless whether he is a guest or an app user), 
  and evaluated by an app user speech evaluator
  */
  Future<Result<Unit, Failure>> deleteSpeechEvaluationNoteAppUser({
    required String chapterMeetingId,
    required String takenByToastmasterId,
    required String noteId,
  });
  Stream<List<TempSpeechEvaluationNote>>
      getSpeechEvaluationNotesForSpecificSpeakerAppUser({
    required String chapterMeetingId,
    //this takenByToastmasterId refers to the current logged app user speech evaluator
    //where the notes are taken by him.
    required String takenByToastmasterId,
    required OnlineSessionCapturedData selectedSpeaker,
  });
  /*
  This method is used to delete the evaluation notes that has been evaluated
  for a specfic speakers (regardless whether he is a guest or an app user), 
  and evaluated by a guest user speech evaluator
  */
  Future<Result<Unit, Failure>> deleteSpeechEvaluationNoteGuestUser({
    required String takenByGuestInvitationCode,
    required String chapterMeetingInvitationCode,
    required String noteId,
  });

  Stream<List<TempSpeechEvaluationNote>> getSpeechEvaluationNotesGuestUser({
    //this takenByGuestInvitationCode refers to the current logged guest user speech evaluator
    //where the notes are taken by him.
    required String chapterMeetingInvitationCode,
    required String takenByGuestInvitationCode,
    required OnlineSessionCapturedData selectedSpeaker,
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

  //this will return a stream of the notes which were taken by an app user speech
  //evaluator, to a speaker whether he is an app user or app guest
  Stream<List<TempSpeechEvaluationNote>> getTakenSpeechNotesByAppUser({
    required String chapterMeetingId,
    required String takenByToastmasterId,
    required bool evaluatedSpeakerIsAppGuest,
    required String? evaluatedSpeakerToastmasteId,
    required String? evaluatedSpeakerGuestInvitationCode,
  });

  //this will return a stream of the notes which were taken by an app guest speech
  //evaluator, to a speaker whether he is an app user or app guest
  Stream<List<TempSpeechEvaluationNote>> getTakenSpeechNotesByAppGuest({
    required String chapterMeetingInvitationCode,
    required String takenByGuestInvitationCode,
    required bool evaluatedSpeakerIsAppGuest,
    required String? evaluatedSpeakerToastmasteId,
    required String? evaluatedSpeakerGuestInvitationCode,
  });
}
