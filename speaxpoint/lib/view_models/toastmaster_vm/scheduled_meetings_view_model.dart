import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/models/chapter_meeting.dart';
import 'package:speaxpoint/services/failure.dart';
import 'package:speaxpoint/services/local_database/i_local_database_service.dart';
import 'package:speaxpoint/services/scheduled_meeting_management/i_scheduled_meeting_management_service.dart';
import 'package:speaxpoint/view_models/base_view_mode.dart';

class ScheduledMeetingsViewModel extends BaseViewModel {
  final IScheduledMeetingManagementService _scheduledMeetingManagementService;

  ScheduledMeetingsViewModel(
    this._scheduledMeetingManagementService,
  );

  Future<List<ChapterMeeting>> getScheduledChapterMeetings() async {
    List<ChapterMeeting> chatperMeetings = [];
    setLoading(loading: true);

    await _scheduledMeetingManagementService
        .getAllScheduledMeeting(
            clubId: await super.getDataFromLocalDataBase(keySearch: "clubId"),
            toastmasterId: await super
                .getDataFromLocalDataBase(keySearch: "toastmasterId"))
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

  Future<Result<Unit, Failure>> launchSession(
      {required String chapterMeetingId}) async {
    return await _scheduledMeetingManagementService
        .lanuchChapterMeetingSessions(chapterMeetingId: chapterMeetingId);
  }

  Future<Result<Unit, Failure>> joinSession(
      {required String chapterMeetingId}) async {
    return await _scheduledMeetingManagementService
        .joinChapterMeetingSessionAppUser(chapterMeetingId: chapterMeetingId);
  }
}
