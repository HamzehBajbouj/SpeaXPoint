import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/models/evaluation_notes/evaluation_note.dart';
import 'package:speaxpoint/models/evaluation_notes/temp_evaluation_note.dart';
import 'package:speaxpoint/models/online_session.dart';
import 'package:speaxpoint/models/online_session_captured_data.dart';
import 'package:speaxpoint/services/failure.dart';
import 'package:speaxpoint/services/live_session/i_live_session_service.dart';
import 'package:speaxpoint/view_models/base_view_mode.dart';
import 'package:uuid/uuid.dart';

class ManageEvaluationViewModel extends BaseViewModel {
  final ILiveSessionService _liveSessionService;

  ManageEvaluationViewModel(this._liveSessionService);

  Stream<List<EvaluationNote>> getGeneralEvaluationNotes({
    required bool isAnAppGuest,
    String? chapterMeetingId,
    String? toastmasterId,
    String? guestInvitationCode,
    String? chapterMeetingInvitationCode,
  }) {
    if (isAnAppGuest) {
      return _liveSessionService.getGeneralEvaluationNoteGuestUser(
          chapterMeetingInvitationCode: chapterMeetingInvitationCode!,
          guestInvitationCode: guestInvitationCode!);
    } else {
      return _liveSessionService.getGeneralEvaluationNoteAppUser(
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
      await _liveSessionService.addGeneralEvaluationNoteGuestUser(
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
      await _liveSessionService.addGeneralEvaluationNoteAppUser(
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

      return await _liveSessionService.deleteGeneralEvaluationNoteGuestUser(
        guestInvitationCode: guestInvitationCode!,
        chapterMeetingInvitationCode: chapterMeetingInvitationCode!,
        noteId: noteId,
      );
    } else {
      setLoading(loading: false);

      return await _liveSessionService.deleteGeneralEvaluationNoteAppUser(
        chapterMeetingId: chapterMeetingId!,
        toastmasterId: toastmasterId!,
        noteId: noteId,
      );
    }
  }

  Stream<OnlineSession> getOnlineSessionDetails({
    required bool isAnAppGuest,
    String? chapterMeetingId,
    String? chapterMeetingInvitationCode,
  }) {
    return _liveSessionService.getOnlineSessionDetails(
        isAnAppGuest: isAnAppGuest,
        chapterMeetingId: chapterMeetingId,
        chapterMeetingInvitationCode: chapterMeetingInvitationCode);
  }

  Future<void> addSpeechEvaluationNote({
    required OnlineSession onlineSessionDetails,
    required String noteContent,
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

    await _liveSessionService.addSpeechEvaluationNote(
      evaluationNote: TempSpeechEvaluationNote(
        chapterMeetingId: chapterMeetingId,
        chapterMeetingInvitationCode: chapterMeetingInvitationCode,
        takenByGuestInvitationCode: takenByGuestInvitationCode,
        takenByToastmasterId: takenByToastmasterId,
        evaluatedSpeakerGuestInvitationCode:
            onlineSessionDetails.currentGuestSpeakerInvitationCode,
        evaluatedSpeakerToastmasteId:
            onlineSessionDetails.currentSpeakerToastmasterId,
        noteContent: noteContent,
        noteId: randomId2,
        noteTakenTime: DateTime.now().toUtc().toString(),
        noteTitle: noteTitle,
      ),
    );
    setLoading(loading: false);
  }

  Future<List<OnlineSessionCapturedData>> getListOfSpeechesSpeakers({
    required bool isAGuest,
    String? chapterMeetingId,
    String? toastmasterId,
    String? guestInvitationCode,
    String? chapterMeetingInvitationCode,
  }) async {
    List<OnlineSessionCapturedData> tempList = [];
    setLoading(loading: true);
    if (isAGuest) {
      await _liveSessionService
          .getListOfSpeachesSpeakersForAppGuest(
              chapterMeetingInvitationCode: chapterMeetingInvitationCode!,
              guestInvitationCode: guestInvitationCode!)
          .then(
        (value) {
          value.whenSuccess(
            (success) {
              tempList = success;
            },
          );
        },
      );
    } else {
      await _liveSessionService
          .getListOfSpeachesSpeakersForAppUser(
              chapterMeetingId: chapterMeetingId!)
          .then(
        (value) {
          value.whenSuccess(
            (success) {
              tempList = success;
            },
          );
        },
      );
    }
    setLoading(loading: false);
    return tempList;
  }

  Stream<List<TempSpeechEvaluationNote>> getTakenNotes({
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
      return _liveSessionService.getTakenSpeechNotesByAppGuest(
          chapterMeetingInvitationCode: chapterMeetingInvitationCode!,
          takenByGuestInvitationCode: guestInvitationCode!,
          evaluatedSpeakerIsAppGuest: evaluatedSpeakerIsAppGuest,
          evaluatedSpeakerToastmasteId: evaluatedSpeakerToastmasteId,
          evaluatedSpeakerGuestInvitationCode:
              evaluatedSpeakerGuestInvitationCode);
    } else {
      return _liveSessionService.getTakenSpeechNotesByAppUser(
          chapterMeetingId: chapterMeetingId!,
          takenByToastmasterId: toastmasterId!,
          evaluatedSpeakerIsAppGuest: evaluatedSpeakerIsAppGuest,
          evaluatedSpeakerToastmasteId: evaluatedSpeakerToastmasteId,
          evaluatedSpeakerGuestInvitationCode:
              evaluatedSpeakerGuestInvitationCode);
    }
  }

    Future<Result<Unit, Failure>> deleteSpeechEvaluationNote({
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

      return await _liveSessionService.deleteSpeechEvaluationNoteGuestUser(
        takenByGuestInvitationCode: guestInvitationCode!,
        chapterMeetingInvitationCode: chapterMeetingInvitationCode!,
        noteId: noteId,
      );
    } else {
      setLoading(loading: false);

      return await _liveSessionService.deleteSpeechEvaluationNoteAppUser(
        chapterMeetingId: chapterMeetingId!,
        takenByToastmasterId: toastmasterId!,
        noteId: noteId,
      );
    }
  }
}
