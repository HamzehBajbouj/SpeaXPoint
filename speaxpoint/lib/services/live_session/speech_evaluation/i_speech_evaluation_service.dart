import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/models/evaluation_notes/speech_evaluation_note.dart';
import 'package:speaxpoint/models/online_session_captured_data.dart';
import 'package:speaxpoint/services/failure.dart';

abstract class ISpeechEvaluationService {
  /*
    This part is for Speech Evaluation
    it can be separated into a different interface
  */
  Future<Result<Unit, Failure>> addSpeechEvaluationNote({
    required bool evaluatedSpeakerIsGuest,
    String? evaluatedSpeakerToastmasterId,
    String? evaluatedSpeakerGuestInvitationCode,
    String? chapterMeetingInvitationCode,
    String? chapterMeetingId,
    required SpeechEvaluationNote evaluationNote,
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
    required bool evaluatedSpeakerIsGuest,
    String? evaluatedSpeakerToastmasterId,
    String? evaluatedSpeakerGuestInvitationCode,
  });
  // Stream<List<TempSpeechEvaluationNote>>
  //     getSpeechEvaluationNotesForSpecificSpeakerAppUser({
  //   required String chapterMeetingId,
  //   //this takenByToastmasterId refers to the current logged app user speech evaluator
  //   //where the notes are taken by him.
  //   required String takenByToastmasterId,
  //   required OnlineSessionCapturedData selectedSpeaker,
  //       required bool evaluatedSpeakerIsGuest,
  //   String? evaluatedSpeakerToastmasterId,
  //   String? evaluatedSpeakerGuestInvitationCode,
  // });
  /*
  This method is used to delete the evaluation notes that has been evaluated
  for a specfic speakers (regardless whether he is a guest or an app user), 
  and evaluated by a guest user speech evaluator
  */
  Future<Result<Unit, Failure>> deleteSpeechEvaluationNoteGuestUser({
    required String takenByGuestInvitationCode,
    required String chapterMeetingInvitationCode,
    required String noteId,
    required bool evaluatedSpeakerIsGuest,
    String? evaluatedSpeakerToastmasterId,
    String? evaluatedSpeakerGuestInvitationCode,
  });

//there is no any usages for this method so far
  // Stream<List<TempSpeechEvaluationNote>> getSpeechEvaluationNotesGuestUser({
  //   //this takenByGuestInvitationCode refers to the current logged guest user speech evaluator
  //   //where the notes are taken by him.
  //   required String chapterMeetingInvitationCode,
  //   required String takenByGuestInvitationCode,
  //   required OnlineSessionCapturedData selectedSpeaker,
  //          required bool evaluatedSpeakerIsGuest,
  //   String? evaluatedSpeakerToastmasterId,
  //   String? evaluatedSpeakerGuestInvitationCode,
  // });

  //this will return a stream of the notes which were taken by an app user speech
  //evaluator, to a speaker whether he is an app user or app guest
  Stream<List<SpeechEvaluationNote>> getTakenSpeechNotesByAppUser({
    required String chapterMeetingId,
    required String takenByToastmasterId,
    required bool evaluatedSpeakerIsAppGuest,
    required String? evaluatedSpeakerToastmasteId,
    required String? evaluatedSpeakerGuestInvitationCode,
  });

  //this will return a stream of the notes which were taken by an app guest speech
  //evaluator, to a speaker whether he is an app user or app guest
  Stream<List<SpeechEvaluationNote>> getTakenSpeechNotesByAppGuest({
    required String chapterMeetingInvitationCode,
    required String takenByGuestInvitationCode,
    required bool evaluatedSpeakerIsAppGuest,
    required String? evaluatedSpeakerToastmasteId,
    required String? evaluatedSpeakerGuestInvitationCode,
  });
}
