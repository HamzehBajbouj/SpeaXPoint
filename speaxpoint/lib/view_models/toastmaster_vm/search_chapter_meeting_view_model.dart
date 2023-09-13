import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:speaxpoint/models/annoucement/chapter_meeting_announcement.dart';
import 'package:speaxpoint/services/local_database/i_local_database_service.dart';
import 'package:speaxpoint/services/search_chapter_meeting/i_search_chapter_meeting_service.dart';
import 'package:speaxpoint/util/constants/shared_preferences_keys.dart';
import 'package:speaxpoint/view_models/base_view_mode.dart';

class SearchChapterMeetingViewModel extends BaseViewModel {
  final ISearchChapterMeetingService _searchChapterMeetingService;
  final ILocalDataBaseService _localDataBaseService;
  SearchChapterMeetingViewModel(
      this._searchChapterMeetingService, this._localDataBaseService);

  bool _hasMore = true;
  DocumentSnapshot? _lastDocument;
  List<Map<String, dynamic>> _publishedAnnouncements = [];
  // Getters
  bool get hasMore => _hasMore;

  List<Map<String, dynamic>> get publishedAnnouncements =>
      _publishedAnnouncements;

//Setters
  set hasMore(bool hasMore) {
    _hasMore = hasMore;
  }

  set publishedAnnouncements(List<Map<String, dynamic>> list) {
    _publishedAnnouncements = list;
  }

  Future<void> fetchItems() async {
    if (super.loading || !_hasMore) return;
    setLoading(loading: true);
    Map<String, dynamic> loggedUser =
        await _localDataBaseService.loadData(SharedPrefereneceKeys.loggedUser);
    List<DocumentSnapshot> documents = [];
    await _searchChapterMeetingService
        .getPublishedAllAnnouncements(
      clubId: loggedUser["clubId"],
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
    if (documents.length < 10) {
      _hasMore = false;
    }
    _lastDocument = documents.isNotEmpty ? documents.last : null;
    if (documents.isNotEmpty) {
      _publishedAnnouncements.addAll(
          documents.map((e) => e.data() as Map<String, dynamic>).toList());
    }

    setLoading(loading: false);
  }

  Future<void> searchByClubUsername({required String clubUsername}) async {
    setLoading(loading: true);
    List<DocumentSnapshot> documents = [];
    Map<String, dynamic> loggedUser =
        await _localDataBaseService.loadData(SharedPrefereneceKeys.loggedUser);
    await _searchChapterMeetingService
        .searchForClubAnnouncement(
      searchClubUsername: clubUsername,
      userClubId: loggedUser["clubId"],
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
    _publishedAnnouncements.clear();
    _publishedAnnouncements.addAll(
        documents.map((e) => e.data() as Map<String, dynamic>).toList());
    setLoading(loading: false);
  }

  void clearSearch() {
    setLoading(loading: true);
    _lastDocument = null;
    _hasMore = true;
    _publishedAnnouncements.clear();
    setLoading(loading: false);
  }
}
