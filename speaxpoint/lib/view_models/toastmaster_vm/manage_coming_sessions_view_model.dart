import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/models/chapter_meeting.dart';
import 'package:speaxpoint/services/Failure.dart';
import 'package:speaxpoint/services/local_database/i_local_database_service.dart';
import 'package:speaxpoint/services/manage_coming_sessions/i_manage_coming_sessions_service.dart';
import 'package:speaxpoint/util/constants/common_enums.dart';
import 'package:speaxpoint/util/constants/shared_preferences_keys.dart';
import 'package:speaxpoint/view_models/base_view_mode.dart';
import 'package:uuid/uuid.dart';

class ManageComingSessionsViewModel extends BaseViewModel {
  final ILocalDataBaseService _sharedPreferences;
  final IManageComingSessionsService _manageComingSessionsService;

  Result<Unit, Failure>? _createdNewSessionStatus;
  Result<Unit, Failure>? get getCreatedNewSessionsStatus =>
      _createdNewSessionStatus;

  ManageComingSessionsViewModel(
      this._sharedPreferences, this._manageComingSessionsService);

  Future<void> createNewSession(String sessionTitle, String sessionDate) async {
    super.setLoading(true);
    //get currentUserId and club Id
    Map<String, dynamic> loggedUser =
        await _sharedPreferences.loadData(SharedPrefereneceKeys.loggedUser);
    //create a radom uuid for the invitation code
    String invitationCode = Uuid().v4();
    invitationCode = invitationCode.substring(0, invitationCode.indexOf("-"));

    _createdNewSessionStatus =
        await _manageComingSessionsService.createNewSession(
      ChapterMeeting(
        chapterTitle: sessionTitle,
        dateOfMeeting: sessionDate,
        invitationCode: invitationCode,
        chapterMeetingStatus: ComingSessionsStatus.Pending.name,
        clubId: loggedUser["clubId"],
        toastmasterId: loggedUser["toastmasterName"],
      ),
    );
    super.setLoading(false);
  }

  //this function will return the a Stream,and then we will use the streambuilder for that
  /*
  in the stream builder if there is change in the data fetched from firestore,
   will it triger a rebuild by it's self??
 Yes, a change in the data emitted by the stream will trigger the StreamBuilder to
 rebuild itself with the new data. This is because the StreamBuilder listens to 
 the stream and rebuilds itself whenever new data is emitted by the stream.

 In other words, the StreamBuilder is a reactive widget that automatically rebuilds
 itself when the stream emits a new event. This is one of the benefits of using
 the StreamBuilder in Flutter - it allows you to build UI that automatically updates as new data becomes available.
  */
  Stream<List<ChapterMeeting>> getChapterMeetingsList() {
    return _manageComingSessionsService.getAllComingSessions();
  }
}
