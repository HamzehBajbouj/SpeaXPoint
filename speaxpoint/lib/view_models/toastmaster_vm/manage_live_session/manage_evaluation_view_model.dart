import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/models/evaluation_note.dart';
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
}
