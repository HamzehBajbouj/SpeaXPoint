import 'package:speaxpoint/models/evaluation_notes/speech_evaluation_note.dart';
import 'package:speaxpoint/models/grammarian_note.dart';
import 'package:speaxpoint/models/speech_timing.dart';
import 'package:speaxpoint/services/live_session/grammarian/i_grammarian_service.dart';
import 'package:speaxpoint/services/live_session/i_live_session_service.dart';
import 'package:speaxpoint/services/live_session/speech_evaluation/i_speech_evaluation_service.dart';
import 'package:speaxpoint/services/live_session/time_filler/i_time_filler_service.dart';
import 'package:speaxpoint/services/live_session/timer/i_timing_role_service.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/manage_live_session/common_live_session_method_view_model.dart';

class SpeechObservationsViewModel extends CommonLiveSessionMethodsViewModel {
  final ILiveSessionService _liveSessionService;
  final IGrammarianService _grammarianService;
  final ISpeechEvaluationService _speechEvaluationService;
  final ITimeFillerService _timeFillerService;
  final ITimingRoleService _timingRoleService;

  SpeechObservationsViewModel(
      this._liveSessionService,
      this._grammarianService,
      this._speechEvaluationService,
      this._timeFillerService,
      this._timingRoleService)
      : super(_liveSessionService);

  Stream<int> getTimeFillersCounter({
    required bool currentSpeakerisAppGuest,
    String? currentSpeakerToastmasterId,
    String? currentSpeakerGuestInvitationCode,
    String? chapterMeetingInvitationCode,
    String? chapterMeetingId,
  }) {
    return _timeFillerService.getTotalNumberOfTimeFillers(
      currentSpeakerisAppGuest: currentSpeakerisAppGuest,
      chapterMeetingId: chapterMeetingId,
      chapterMeetingInvitationCode: chapterMeetingInvitationCode,
      currentSpeakerGuestInvitationCode: currentSpeakerGuestInvitationCode,
      currentSpeakerToastmasterId: currentSpeakerToastmasterId,
    );
  }

  Stream<int> getEvaluationNotesCounter({
    required bool currentSpeakerisAppGuest,
    String? currentSpeakerToastmasterId,
    String? currentSpeakerGuestInvitationCode,
    String? chapterMeetingInvitationCode,
    String? chapterMeetingId,
  }) {
    return _speechEvaluationService.getTotalNumberOfEvaluationNotes(
      currentSpeakerisAppGuest: currentSpeakerisAppGuest,
      chapterMeetingId: chapterMeetingId,
      chapterMeetingInvitationCode: chapterMeetingInvitationCode,
      currentSpeakerGuestInvitationCode: currentSpeakerGuestInvitationCode,
      currentSpeakerToastmasterId: currentSpeakerToastmasterId,
    );
  }

  Stream<int> getGrammaticalNotesCounter({
    required bool currentSpeakerisAppGuest,
    String? currentSpeakerToastmasterId,
    String? currentSpeakerGuestInvitationCode,
    String? chapterMeetingInvitationCode,
    String? chapterMeetingId,
  }) {
    return _grammarianService.getTotalNumberOfGrammaticalNotes(
      currentSpeakerisAppGuest: currentSpeakerisAppGuest,
      chapterMeetingId: chapterMeetingId,
      chapterMeetingInvitationCode: chapterMeetingInvitationCode,
      currentSpeakerGuestInvitationCode: currentSpeakerGuestInvitationCode,
      currentSpeakerToastmasterId: currentSpeakerToastmasterId,
    );
  }

  Stream<int> getWOTDCounter({
    required bool currentSpeakerisAppGuest,
    String? currentSpeakerToastmasterId,
    String? currentSpeakerGuestInvitationCode,
    String? chapterMeetingInvitationCode,
    String? chapterMeetingId,
  }) {
    return _grammarianService.getWOTDUsagesLiveDataCount(
      currentSpeakerisAppGuest: currentSpeakerisAppGuest,
      chapterMeetingId: chapterMeetingId,
      chapterMeetingInvitationCode: chapterMeetingInvitationCode,
      currentSpeakerGuestInvitationCode: currentSpeakerGuestInvitationCode,
      currentSpeakerToastmasterId: currentSpeakerToastmasterId,
    );
  }

  Stream<List<SpeechEvaluationNote>> getAllEvaluationNotes({
    required bool currentSpeakerisAppGuest,
    String? currentSpeakerToastmasterId,
    String? currentSpeakerGuestInvitationCode,
    String? chapterMeetingInvitationCode,
    String? chapterMeetingId,
  }) {
    return _speechEvaluationService.getAllLiveDataEvaluationNotes(
      currentSpeakerisAppGuest: currentSpeakerisAppGuest,
      chapterMeetingId: chapterMeetingId,
      chapterMeetingInvitationCode: chapterMeetingInvitationCode,
      currentSpeakerGuestInvitationCode: currentSpeakerGuestInvitationCode,
      currentSpeakerToastmasterId: currentSpeakerToastmasterId,
    );
  }

  Stream<List<GrammarianNote>> getAllGrammaticalNotes({
    required bool currentSpeakerisAppGuest,
    String? currentSpeakerToastmasterId,
    String? currentSpeakerGuestInvitationCode,
    String? chapterMeetingInvitationCode,
    String? chapterMeetingId,
  }) {
    return _grammarianService.getGrammaticalNotes(
      currentSpeakerisAppGuest: currentSpeakerisAppGuest,
      chapterMeetingId: chapterMeetingId,
      chapterMeetingInvitationCode: chapterMeetingInvitationCode,
      currentSpeakerGuestInvitationCode: currentSpeakerGuestInvitationCode,
      currentSpeakerToastmasterId: currentSpeakerToastmasterId,
    );
  }

  Stream<SpeechTiming> getSpeechTimingDetails({
    required bool currentSpeakerisAppGuest,
    String? currentSpeakerToastmasterId,
    String? currentSpeakerGuestInvitationCode,
    String? chapterMeetingInvitationCode,
    String? chapterMeetingId,
  }) {
    return _timingRoleService.getSpeakerSpeechTimingLiveData(
      currentSpeakerisAppGuest: currentSpeakerisAppGuest,
      chapterMeetingId: chapterMeetingId,
      chapterMeetingInvitationCode: chapterMeetingInvitationCode,
      currentSpeakerGuestInvitationCode: currentSpeakerGuestInvitationCode,
      currentSpeakerToastmasterId: currentSpeakerToastmasterId,
    );
  }
}
