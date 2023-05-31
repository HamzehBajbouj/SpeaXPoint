import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/models/online_session_captured_data.dart';
import 'package:speaxpoint/services/failure.dart';
import 'package:speaxpoint/services/live_session/i_live_session_service.dart';
import 'package:speaxpoint/view_models/base_view_mode.dart';

class ManageRolesPlayersViewModel extends BaseViewModel {
  final ILiveSessionService _liveSessionService;

  ManageRolesPlayersViewModel(this._liveSessionService);

  Future<DateTime> getLaunchTime({required String chapterMeetingId}) async {
    setLoading(loading: true);
    String launchTime = "00:00:00";
    await _liveSessionService
        .getSessionLaunchingTime(chapterMeetingId: chapterMeetingId)
        .then(
      (value) {
        value.whenSuccess(
          (success) {
            launchTime = success;
          },
        );
      },
    );

    DateTime receivedTime = DateTime.parse(launchTime).toLocal();
    DateTime currentTime = DateTime.now();
    Duration timeDifference = currentTime.difference(receivedTime);
    setLoading(loading: false);
    return currentTime.subtract(timeDifference);
  }

  Future<Result<Unit, Failure>> endChapterMeetingSession(
      {required String chapterMeetingId}) async {
    setLoading(loading: true);
    Result<Unit, Failure> temp = await _liveSessionService
        .endChapterMeetingSession(chapterMeetingId: chapterMeetingId);
    setLoading(loading: false);
    return temp;
  }

  Stream<int> getNumberOfOnlinePeople({required String chapterMeetingId}) {
    return _liveSessionService.getNumberOfOnlinePeople(
        chapterMeetingId: chapterMeetingId);
  }

  Stream<List<OnlineSessionCapturedData>> getListOfSpeaches(
      {required String chapterMeetingId}) {
    return _liveSessionService.getListOfSpeachesForAppUser(
        chapterMeetingId: chapterMeetingId);
  }

  Future<void> selectSpeakerSpeechFromTheList({
    required String chapterMeetingId,
    required bool isAnAppGuest,
    required String? toastmasterId,
    required String? guestInvitationCode,
    required String? chapterMeetingInvitationCode,
  }) async {
    setLoading(loading: true);
    await _liveSessionService.selectSpeech(
      chapterMeetingId: chapterMeetingId,
      isAnAppGuest: isAnAppGuest,
      chapterMeetingInvitationCode: chapterMeetingInvitationCode,
      guestInvitationCode: guestInvitationCode,
      toastmasterId: toastmasterId,
    );
    setLoading(loading: false);
  }
}
