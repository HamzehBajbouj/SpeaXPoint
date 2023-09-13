import 'package:speaxpoint/models/speech_timing.dart';
import 'package:speaxpoint/services/live_session/i_live_session_service.dart';
import 'package:speaxpoint/services/live_session/timer/i_timing_role_service.dart';
import 'package:speaxpoint/view_models/base_view_mode.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/manage_live_session/common_live_session_method_view_model.dart';

class SpeechTimingViewModel extends CommonLiveSessionMethodsViewModel {
  final ITimingRoleService _timingRoleService;
  final ILiveSessionService _liveSessionService;

  SpeechTimingViewModel(this._timingRoleService, this._liveSessionService)
      : super(_liveSessionService);

  Future<void> startTimeCounter({
    required String greenLightLimit,
    required String yellowLightLimit,
    required String redLightLimit,
    required bool currentSpeakerisAppGuest,
    String? currentSpeakerToastmasterId,
    String? currentSpeakerGuestInvitationCode,
    String? chapterMeetingInvitationCode,
    String? chapterMeetingId,
  }) async {
    setLoading(loading: true);

    await _timingRoleService.startCurrentSpeakerTiming(
      speechTiming: SpeechTiming(
        greenLightLimit: int.parse(greenLightLimit),
        yellowLightLimit: int.parse(yellowLightLimit),
        redLightLimit: int.parse(redLightLimit),
        timeCounterStarted: true,
        timeCounterStartingTime: DateTime.now().toUtc().toString(),
      ),
      currentSpeakerisAppGuest: currentSpeakerisAppGuest,
      chapterMeetingId: chapterMeetingId,
      chapterMeetingInvitationCode: chapterMeetingInvitationCode,
      currentSpeakerGuestInvitationCode: currentSpeakerGuestInvitationCode,
      currentSpeakerToastmasterId: currentSpeakerToastmasterId,
    );
    setLoading(loading: false);
  }

  Future<void> stopTimeCounter({
    required bool currentSpeakerisAppGuest,
    String? currentSpeakerToastmasterId,
    String? currentSpeakerGuestInvitationCode,
    String? chapterMeetingInvitationCode,
    String? chapterMeetingId,
  }) async {
    setLoading(loading: true);

    await _timingRoleService.stopCurrentSpeakerTiming(
      speechTiming: SpeechTiming(
        timeCounterStarted: false,
        timeCounterEndingTime: DateTime.now().toUtc().toString(),
      ),
      currentSpeakerisAppGuest: currentSpeakerisAppGuest,
      chapterMeetingId: chapterMeetingId,
      chapterMeetingInvitationCode: chapterMeetingInvitationCode,
      currentSpeakerGuestInvitationCode: currentSpeakerGuestInvitationCode,
      currentSpeakerToastmasterId: currentSpeakerToastmasterId,
    );
    setLoading(loading: false);
  }

  Future<SpeechTiming> getTimingDetails({
    required bool currentSpeakerisAppGuest,
    String? currentSpeakerToastmasterId,
    String? currentSpeakerGuestInvitationCode,
    String? chapterMeetingInvitationCode,
    String? chapterMeetingId,
  }) async {
    SpeechTiming speechTiming = SpeechTiming();
    setLoading(loading: true);
    await _timingRoleService
        .getSpeakerSpeechTimingData(
      currentSpeakerisAppGuest: currentSpeakerisAppGuest,
      chapterMeetingId: chapterMeetingId,
      chapterMeetingInvitationCode: chapterMeetingInvitationCode,
      currentSpeakerGuestInvitationCode: currentSpeakerGuestInvitationCode,
      currentSpeakerToastmasterId: currentSpeakerToastmasterId,
    )
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

  Stream<SpeechTiming> getTimingLiveData({
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
