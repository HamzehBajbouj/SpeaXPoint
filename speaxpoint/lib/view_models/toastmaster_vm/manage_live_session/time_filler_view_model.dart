import 'package:speaxpoint/models/time_filler_captured_data.dart';
import 'package:speaxpoint/services/live_session/i_live_session_service.dart';
import 'package:speaxpoint/services/live_session/time_filler/i_time_filler_service.dart';

import 'common_live_session_method_view_model.dart';

class TimeFillerViewModel extends CommonLiveSessionMethodsViewModel {
  final ILiveSessionService _liveSessionService;
  final ITimeFillerService _timeFillerService;

  TimeFillerViewModel(this._liveSessionService, this._timeFillerService)
      : super(_liveSessionService);

  Future<void> incrementTimeFiller({
    required String typeOfTimeFiller,
    required bool currentSpeakerisAppGuest,
    String? currentSpeakerToastmasterId,
    String? currentSpeakerGuestInvitationCode,
    String? chapterMeetingInvitationCode,
    String? chapterMeetingId,
  }) async {
    await _timeFillerService.increaseTimeFillerCounter(
      timeFillerCapturedData: TimeFillerCapturedData(
          timeOfCapturing: DateTime.now().toUtc().toString(),
          typeOfTimeFiller: typeOfTimeFiller),
      currentSpeakerisAppGuest: currentSpeakerisAppGuest,
      chapterMeetingId: chapterMeetingId,
      chapterMeetingInvitationCode: chapterMeetingInvitationCode,
      currentSpeakerGuestInvitationCode: currentSpeakerGuestInvitationCode,
      currentSpeakerToastmasterId: currentSpeakerToastmasterId,
    );
  }

  Future<void> decrementTimeFiller({
    required String typeOfTimeFiller,
    required bool currentSpeakerisAppGuest,
    String? currentSpeakerToastmasterId,
    String? currentSpeakerGuestInvitationCode,
    String? chapterMeetingInvitationCode,
    String? chapterMeetingId,
  }) async {
    await _timeFillerService.decreaseTimeFillerCounter(
      timeFillerCapturedData:
          TimeFillerCapturedData(typeOfTimeFiller: typeOfTimeFiller),
      currentSpeakerisAppGuest: currentSpeakerisAppGuest,
      chapterMeetingId: chapterMeetingId,
      chapterMeetingInvitationCode: chapterMeetingInvitationCode,
      currentSpeakerGuestInvitationCode: currentSpeakerGuestInvitationCode,
      currentSpeakerToastmasterId: currentSpeakerToastmasterId,
    );
  }

  Future<Map<String, int>> getTimeFillerDetails({
    required bool currentSpeakerisAppGuest,
    String? currentSpeakerToastmasterId,
    String? currentSpeakerGuestInvitationCode,
    String? chapterMeetingInvitationCode,
    String? chapterMeetingId,
  }) async {
    Map<String, int> timeFillerDetails = {};
    setLoading(loading: true);
    await _timeFillerService
        .getSpeakerTimeFillerData(
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
            timeFillerDetails = success;
          },
        );
      },
    );
    setLoading(loading: false);
    return timeFillerDetails;
  }

  Stream<Map<String, int>> getTimeFillerLiveData({
    required bool currentSpeakerisAppGuest,
    String? currentSpeakerToastmasterId,
    String? currentSpeakerGuestInvitationCode,
    String? chapterMeetingInvitationCode,
    String? chapterMeetingId,
  }) {
    return _timeFillerService.getSpeakerTimeFillerLiveData(
      currentSpeakerisAppGuest: currentSpeakerisAppGuest,
      chapterMeetingId: chapterMeetingId,
      chapterMeetingInvitationCode: chapterMeetingInvitationCode,
      currentSpeakerGuestInvitationCode: currentSpeakerGuestInvitationCode,
      currentSpeakerToastmasterId: currentSpeakerToastmasterId,
    );
  }
}
