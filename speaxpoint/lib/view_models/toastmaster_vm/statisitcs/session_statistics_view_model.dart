import 'package:speaxpoint/models/evaluation_notes/speech_evaluation_note.dart';
import 'package:speaxpoint/models/grammarian_note.dart';
import 'package:speaxpoint/models/speech_timing.dart';
import 'package:speaxpoint/services/live_session/grammarian/i_grammarian_service.dart';
import 'package:speaxpoint/services/live_session/speech_evaluation/i_speech_evaluation_service.dart';
import 'package:speaxpoint/services/live_session/time_filler/i_time_filler_service.dart';
import 'package:speaxpoint/services/live_session/timer/i_timing_role_service.dart';
import 'package:speaxpoint/view_models/base_view_mode.dart';

class SessionStatisticsViewModel extends BaseViewModel {
  final IGrammarianService _grammarianService;
  final ISpeechEvaluationService _speechEvaluationService;
  final ITimeFillerService _timeFillerService;
  final ITimingRoleService _timingRoleService;

  SessionStatisticsViewModel(
      this._grammarianService,
      this._speechEvaluationService,
      this._timeFillerService,
      this._timingRoleService);

  Future<Map<String, int>> getTimeFillerDetails({
    required String toastmasterId,
    required String chapterMeetingId,
  }) async {
    Map<String, int> timeFillerDetails = {};
    setLoading(loading: true);
    await _timeFillerService
        .getSpeakerTimeFillerData(
      currentSpeakerisAppGuest: false,
      chapterMeetingId: chapterMeetingId,
      currentSpeakerToastmasterId: toastmasterId,
    )
        .then(
      (value) {
        value.whenSuccess(
          (success) {
            timeFillerDetails = success;
          },
        );
      },
    );
    setLoading(loading: false);
    return timeFillerDetails;
  }

  Future<List<SpeechEvaluationNote>> getAllEvaluationNotes({
    required String chapterMeetingId,
    required String toastmasterId,
  }) async {
    setLoading(loading: true);
    List<SpeechEvaluationNote> tempList = [];
    await _speechEvaluationService
        .getAllEvaluationNotes(
      currentSpeakerisAppGuest: false,
      chapterMeetingId: chapterMeetingId,
      currentSpeakerToastmasterId: toastmasterId,
    )
        .then(
      (value) {
        value.whenSuccess(
          (success) {
            tempList = success;
          },
        );
      },
    );

    setLoading(loading: false);
    return tempList;
  }

  Future<List<GrammarianNote>> getAllGrammaticalNotes({
    required String chapterMeetingId,
    required String toastmasterId,
  }) async {
    setLoading(loading: true);
    List<GrammarianNote> tempList = [];
    await _grammarianService
        .getAllTakenGrammaticalNotes(
      currentSpeakerisAppGuest: false,
      chapterMeetingId: chapterMeetingId,
      currentSpeakerToastmasterId: toastmasterId,
    )
        .then(
      (value) {
        value.whenSuccess(
          (success) {
            tempList = success;
          },
        );
      },
    );

    setLoading(loading: false);
    return tempList;
  }

  Future<SpeechTiming> getSpeechTimingData({
    required String chapterMeetingId,
    required String toastmasterId,
  }) async {
    SpeechTiming speechTiming = SpeechTiming();
    setLoading(loading: true);
    await _timingRoleService
        .getSpeakerSpeechTimingData(
            currentSpeakerisAppGuest: false,
            chapterMeetingId: chapterMeetingId,
            currentSpeakerToastmasterId: toastmasterId)
        .then(
      (value) {
        value.whenSuccess(
          (success) {
            speechTiming = success;
          },
        );
      },
    );
    setLoading(loading: false);
    return speechTiming;
  }
}
