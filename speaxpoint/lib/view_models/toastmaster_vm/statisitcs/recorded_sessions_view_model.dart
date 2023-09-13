import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:speaxpoint/models/chapter_meeting.dart';
import 'package:speaxpoint/services/statistics/i_statistics_service.dart';
import 'package:speaxpoint/util/constants/common_enums.dart';
import 'package:speaxpoint/view_models/base_view_mode.dart';

class RecordedSessionViewModel extends BaseViewModel {
  final IStatisticsService _statisticsService;

  RecordedSessionViewModel(this._statisticsService);
  bool hasMore = true;
  DocumentSnapshot? _lastDocument;
  Map<String, List<Map<String, dynamic>>> recordedSession = {};

  Future<void> fetchItems({bool? resetEverything}) async {
    if (resetEverything != null && resetEverything) {
      hasMore = true;
      recordedSession.clear();
      _lastDocument = null;
    }
    if (super.loading || !hasMore) return;
    setLoading(loading: true);
    String loggedUserId =
        await super.getDataFromLocalDataBase(keySearch: "toastmasterId");
    Map<String, List<DocumentSnapshot>> documents = {};
    await _statisticsService
        .getListOfAllSpeechesSessions(
      toastmasterId: loggedUserId,
      startAfter: _lastDocument,
    )
        .then(
      (value) {
        value.whenSuccess(
          (success) {
            documents = success;
          },
        );
      },
    );

    if (documents.isNotEmpty && documents["ChapterMeetings"]!.length < 10) {
      hasMore = false;
    }
    _lastDocument = documents.isNotEmpty
        ? documents["OnlineSessionCapturedData"]?.last
        : null;

    if (documents.isNotEmpty) {
      // to only display the chpater meeting that are completed
      for (int i = 0; i < documents["OnlineSessionCapturedData"]!.length; i++) {
        ChapterMeeting temp = ChapterMeeting.fromJson(
            documents["ChapterMeetings"]![i].data() as Map<String, dynamic>);

        if (temp.chapterMeetingStatus != ComingSessionsStatus.Completed.name) {
          documents["OnlineSessionCapturedData"]!.removeAt(i);
          documents["ChapterMeetings"]!.removeAt(i);
        }
      }

      if (documents["OnlineSessionCapturedData"] != null &&
          documents["OnlineSessionCapturedData"]!.isNotEmpty) {
        if (!recordedSession.containsKey("OnlineSessionCapturedData")) {
          recordedSession["OnlineSessionCapturedData"] = [];
        }
        if (!recordedSession.containsKey("ChapterMeetings")) {
          recordedSession["ChapterMeetings"] = [];
        }

        recordedSession["OnlineSessionCapturedData"]!.addAll(
            documents["OnlineSessionCapturedData"]!
                .map((e) => e.data() as Map<String, dynamic>)
                .toList());
        recordedSession["ChapterMeetings"]!.addAll(documents["ChapterMeetings"]!
            .map((e) => e.data() as Map<String, dynamic>)
            .toList());
      }
    }
    setLoading(loading: false);
  }
}
