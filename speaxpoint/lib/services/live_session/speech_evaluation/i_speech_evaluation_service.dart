import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/models/evaluation_notes/temp_evaluation_note.dart';
import 'package:speaxpoint/models/online_session_captured_data.dart';
import 'package:speaxpoint/services/failure.dart';

abstract class ISpeechEvaluationService {

    /*
    This part is for Speech Evaluation
    it can be separated into a different interface
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
