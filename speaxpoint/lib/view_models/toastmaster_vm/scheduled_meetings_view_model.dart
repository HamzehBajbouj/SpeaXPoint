import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/models/chapter_meeting.dart';
import 'package:speaxpoint/services/failure.dart';
import 'package:speaxpoint/services/local_database/i_local_database_service.dart';
import 'package:speaxpoint/services/scheduled_meeting_management/i_scheduled_meeting_management_service.dart';
import 'package:speaxpoint/util/constants/shared_preferences_keys.dart';
import 'package:speaxpoint/view_models/base_view_mode.dart';

class ScheduledMeetingsViewModel extends BaseViewModel {
  final IScheduledMeetingManagementService _scheduledMeetingManagementService;
  final ILocalDataBaseService _localDataBaseService;

  ScheduledMeetingsViewModel(
      this._scheduledMeetingManagementService, this._localDataBaseService);

  Future<List<ChapterMeeting>> getScheduledChapterMeetings() async {
    List<ChapterMeeting> chatperMeetings = [];
    setLoading(loading: true);
    Map<String, dynamic> loggedUser =
        await _localDataBaseService.loadData(SharedPrefereneceKeys.loggedUser);
    await _scheduledMeetingManagementService
        .getAllScheduledMeeting(
            clubId: loggedUser["clubId"],
            toastmasterId: loggedUser["toastmasterId"])
        .then(
      (value) {
        value.whenSuccess(
          (success) {
            chatperMeetings = success;
          },
        );
      },
    );
    setLoading(loading: false);
    return chatperMeetings;
  }

  Future<String> getMemberClubRole() async {
    Map<String, dynamic> loggedUser =
        await _localDataBaseService.loadData(SharedPrefereneceKeys.loggedUser);
    return loggedUser["memberOfficalRole"];
  }

  Future<Result<Unit, Failure>> launchSession(
      {required String chapterMeetingId}) async {
    return await _scheduledMeetingManagementService
        .lanuchChapterMeetingSessions(chapterMeetingId: chapterMeetingId);
  }
}
