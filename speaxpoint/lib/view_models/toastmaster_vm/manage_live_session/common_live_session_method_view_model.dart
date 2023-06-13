import 'package:speaxpoint/models/online_session.dart';
import 'package:speaxpoint/models/online_session_captured_data.dart';
import 'package:speaxpoint/services/live_session/i_live_session_service.dart';
import 'package:speaxpoint/view_models/base_view_mode.dart';

class CommonLiveSessionMethodsViewModel extends BaseViewModel {
  final ILiveSessionService _liveSessionService;

  CommonLiveSessionMethodsViewModel(this._liveSessionService);
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

  Future<List<OnlineSessionCapturedData>> getListOfSpeechesSpeakers({
    required bool isAGuest,
    String? chapterMeetingId,
    String? chapterMeetingInvitationCode,
  }) async {
    List<OnlineSessionCapturedData> tempList = [];
    setLoading(loading: true);
    if (isAGuest) {
      await _liveSessionService
          .getListOfSpeachesSpeakersForAppGuest(
              chapterMeetingInvitationCode: chapterMeetingInvitationCode!,
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
}
