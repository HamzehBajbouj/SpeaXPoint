import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/services/failure.dart';
import 'package:speaxpoint/services/session_redirection/i_session_redirection_service.dart';
import 'package:speaxpoint/util/constants/common_enums.dart';
import 'package:speaxpoint/view_models/base_view_mode.dart';

class SessionRedirectionViewModel extends BaseViewModel {
  final ISessionRedirectionService _sessionRedirectionService;

  SessionRedirectionViewModel(this._sessionRedirectionService);

  Future<String> getTargetScreen({
    required bool isAGuest,
    String? chapterMeetingId,
    String? chapterMeetingInvitationCode,
    String? guestInvitationCode,
    bool? guestHasRole,
  }) async {
    setLoading(loading: true);
    String tempRoleName = LisrOfRolesPlayers.MeetingVisitor.name;
    if (isAGuest) {
      if (guestHasRole!) {
        await _sessionRedirectionService
            .getAppGuestRoleName(
                chapterMeetingInvitationCode: chapterMeetingInvitationCode!,
                guestInvitationCode: guestInvitationCode!)
            .then(
          (value) {
            value.whenSuccess(
              (success) {
                tempRoleName = success;
              },
            );
          },
        );
        setLoading(loading: false);

        return tempRoleName;
      } else {
        setLoading(loading: false);
        return LisrOfRolesPlayers.MeetingVisitor.name;
      }
    } else {
      await _sessionRedirectionService
          .getAppUserRoleName(
        chapterMeetingId: chapterMeetingId!,
        toastmasterId:
            await super.getDataFromLocalDataBase(keySearch: "toastmasterId"),
      )
          .then(
        (value) {
          value.whenSuccess(
            (success) {
              tempRoleName = success;
            },
          );
        },
      );

      setLoading(loading: false);
      return tempRoleName;
    }
  }

  Future<Result<Unit, Failure>> leaveTheSession({
    required bool isAGuest,
    String? chapterMeetingId,
    String? chapterMeetingInvitationCode,
  }) async {
    setLoading(loading: true);
    if (isAGuest) {
      setLoading(loading: false);
      return await _sessionRedirectionService
          .leaveTheChapterMeetingSessionGuestUser(
              chapterMeetingInvitationCode: chapterMeetingInvitationCode!);
    } else {
      setLoading(loading: false);
      return await _sessionRedirectionService
          .leaveTheChapterMeetingSessionAppUser(
              chapterMeetingId: chapterMeetingId!);
    }
  }
}
