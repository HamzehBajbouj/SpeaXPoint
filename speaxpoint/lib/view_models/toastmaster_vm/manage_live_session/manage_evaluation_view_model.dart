import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/models/evaluation_notes/evaluation_note.dart';
import 'package:speaxpoint/models/evaluation_notes/speech_evaluation_note.dart';
import 'package:speaxpoint/services/failure.dart';
import 'package:speaxpoint/services/live_session/general_evaluation/i_general_evaluation_service.dart';
import 'package:speaxpoint/services/live_session/i_live_session_service.dart';
import 'package:speaxpoint/services/live_session/speech_evaluation/i_speech_evaluation_service.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/manage_live_session/common_live_session_method_view_model.dart';
import 'package:uuid/uuid.dart';

class ManageEvaluationViewModel extends CommonLiveSessionMethodsViewModel {
  final ILiveSessionService _liveSessionService;
  final ISpeechEvaluationService _speechEvaluationService;
  final IGeneralEvaluationService _generalEvaluationService;

  ManageEvaluationViewModel(this._liveSessionService,
      this._speechEvaluationService, this._generalEvaluationService)
      : super(_liveSessionService);

  Stream<List<EvaluationNote>> getGeneralEvaluationNotes({
    required bool isAnAppGuest,
    String? chapterMeetingId,
    String? toastmasterId,
    String? guestInvitationCode,
    String? chapterMeetingInvitationCode,
  }) {
    if (isAnAppGuest) {
      return _generalEvaluationService.getGeneralEvaluationNoteGuestUser(
          chapterMeetingInvitationCode: chapterMeetingInvitationCode!,
          guestInvitationCode: guestInvitationCode!);
    } else {
      return _generalEvaluationService.getGeneralEvaluationNoteAppUser(
          chapterMeetingId: chapterMeetingId!, toastmasterId: toastmasterId!);
    }
  }

  Future<void> addNewGeneralEvaluationNote({
    required bool isAGuest,
    required String noteContent,
    String? noteTitle,
    String? chapterMeetingId,
    String? toastmasterId,
    String? guestInvitationCode,
    String? chapterMeetingInvitationCode,
  }) async {
    setLoading(loading: true);
    const uuid = Uuid();
    String randomId1 = uuid.v4();
    randomId1 = "nid${randomId1.substring(0, randomId1.indexOf("-"))}";
    // //for create the unique id, just create random Id and add the randomId1 at the end.
    String randomId2 = uuid.v4();
    randomId2 = randomId2.substring(0, randomId2.indexOf("-")) + randomId1;

    if (isAGuest) {
      await _generalEvaluationService.addGeneralEvaluationNoteGuestUser(
        guestInvitationCode: guestInvitationCode!,
        chapterMeetingInvitationCode: chapterMeetingInvitationCode!,
        evaluationNote: EvaluationNote(
          noteTakenTime: DateTime.now().toUtc().toString(),
          noteContent: noteContent,
          noteId: randomId2,
          noteTitle: noteTitle,
        ),
      );
    } else {
      await _generalEvaluationService.addGeneralEvaluationNoteAppUser(
        chapterMeetingId: chapterMeetingId!,
        toastmasterId: toastmasterId!,
        evaluationNote: EvaluationNote(
          noteTakenTime: DateTime.now().toUtc().toString(),
          noteContent: noteContent,
          noteId: randomId2,
          noteTitle: noteTitle,
        ),
      );
    }
    setLoading(loading: false);
  }

  Future<Result<Unit, Failure>> deleteGeneralEvaluationNote({
    required bool isAGuest,
    required String noteId,
    String? chapterMeetingId,
    String? toastmasterId,
    String? guestInvitationCode,
    String? chapterMeetingInvitationCode,
  }) async {
    setLoading(loading: true);

    if (isAGuest) {
      setLoading(loading: false);

      return await _generalEvaluationService
          .deleteGeneralEvaluationNoteGuestUser(
        guestInvitationCode: guestInvitationCode!,
        chapterMeetingInvitationCode: chapterMeetingInvitationCode!,
        noteId: noteId,
      );
    } else {
      setLoading(loading: false);

      return await _generalEvaluationService.deleteGeneralEvaluationNoteAppUser(
        chapterMeetingId: chapterMeetingId!,
        toastmasterId: toastmasterId!,
        noteId: noteId,
      );
    }
  }

  //this part is for the speech evalautions calls
  Future<void> addSpeechEvaluationNote({
    required bool evaluatedSpeakerIsGuest,
    required String noteContent,
    String? evaluatedSpeakerToastmasterId,
    String? evaluatedSpeakerGuestInvitationCode,
    String? noteTitle,
    String? chapterMeetingId,
    String? takenByToastmasterId,
    String? takenByGuestInvitationCode,
    String? chapterMeetingInvitationCode,
  }) async {
    setLoading(loading: true);
    const uuid = Uuid();
    String randomId1 = uuid.v4();
    randomId1 = "snid${randomId1.substring(0, randomId1.indexOf("-"))}";
    // //for create the unique id, just create random Id and add the randomId1 at the end.
    String randomId2 = uuid.v4();
    randomId2 = randomId1 + randomId2.substring(0, randomId2.indexOf("-"));

    await _speechEvaluationService.addSpeechEvaluationNote(
      evaluatedSpeakerIsGuest: evaluatedSpeakerIsGuest,
      chapterMeetingId: chapterMeetingId,
      chapterMeetingInvitationCode: chapterMeetingInvitationCode,
      evaluatedSpeakerGuestInvitationCode: evaluatedSpeakerGuestInvitationCode,
      evaluatedSpeakerToastmasterId: evaluatedSpeakerToastmasterId,
      evaluationNote: SpeechEvaluationNote(
        takenByGuestInvitationCode: takenByGuestInvitationCode,
        takenByToastmasterId: takenByToastmasterId,
        noteContent: noteContent,
        noteId: randomId2,
        noteTakenTime: DateTime.now().toUtc().toString(),
        noteTitle: noteTitle,
      ),
    );
    setLoading(loading: false);
  }

  Stream<List<SpeechEvaluationNote>> getTakenNotes({
    //isAGuest is for the speech evalautor , the current screen user
    //who is using the evalation speech screen
    required bool isAGuest,
    String? chapterMeetingId,
    String? toastmasterId,
    String? guestInvitationCode,
    String? chapterMeetingInvitationCode,
    required bool evaluatedSpeakerIsAppGuest,
    required String? evaluatedSpeakerToastmasteId,
    required String? evaluatedSpeakerGuestInvitationCode,
  }) {
    if (isAGuest) {
      return _speechEvaluationService.getTakenSpeechNotesByAppGuest(
          chapterMeetingInvitationCode: chapterMeetingInvitationCode!,
          takenByGuestInvitationCode: guestInvitationCode!,
          evaluatedSpeakerIsAppGuest: evaluatedSpeakerIsAppGuest,
          evaluatedSpeakerToastmasteId: evaluatedSpeakerToastmasteId,
          evaluatedSpeakerGuestInvitationCode:
              evaluatedSpeakerGuestInvitationCode);
    } else {
      return _speechEvaluationService.getTakenSpeechNotesByAppUser(
          chapterMeetingId: chapterMeetingId!,
          takenByToastmasterId: toastmasterId!,
          evaluatedSpeakerIsAppGuest: evaluatedSpeakerIsAppGuest,
          evaluatedSpeakerToastmasteId: evaluatedSpeakerToastmasteId,
          evaluatedSpeakerGuestInvitationCode:
              evaluatedSpeakerGuestInvitationCode);
    }
  }

  Future<Result<Unit, Failure>> deleteSpeechEvaluationNote({
    required bool evaluatedSpeakerIsGuest,
    required bool isAGuest,
    required String noteId,
    String? chapterMeetingId,
    String? toastmasterId,
    String? guestInvitationCode,
    String? chapterMeetingInvitationCode,
    String? evaluatedSpeakerToastmasterId,
    String? evaluatedSpeakerGuestInvitationCode,
  }) async {
    setLoading(loading: true);

    if (isAGuest) {
      setLoading(loading: false);

      return await _speechEvaluationService.deleteSpeechEvaluationNoteGuestUser(
        takenByGuestInvitationCode: guestInvitationCode!,
        chapterMeetingInvitationCode: chapterMeetingInvitationCode!,
        noteId: noteId,
        evaluatedSpeakerIsGuest: evaluatedSpeakerIsGuest,
        evaluatedSpeakerGuestInvitationCode:
            evaluatedSpeakerGuestInvitationCode,
        evaluatedSpeakerToastmasterId: evaluatedSpeakerToastmasterId,
      );
    } else {
      setLoading(loading: false);

      return await _speechEvaluationService.deleteSpeechEvaluationNoteAppUser(
        chapterMeetingId: chapterMeetingId!,
        takenByToastmasterId: toastmasterId!,
        noteId: noteId,
        evaluatedSpeakerIsGuest: evaluatedSpeakerIsGuest,
        evaluatedSpeakerGuestInvitationCode:
            evaluatedSpeakerGuestInvitationCode,
        evaluatedSpeakerToastmasterId: evaluatedSpeakerToastmasterId,
      );
    }
  }
}
