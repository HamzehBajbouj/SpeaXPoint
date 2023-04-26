import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:speaxpoint/models/annoucement/chapter_meeting_announcement.dart';
import 'package:speaxpoint/services/search_chapter_meeting/i_search_chapter_meeting_service.dart';
import 'package:speaxpoint/view_models/base_view_mode.dart';

class SearchChapterMeetingViewModel extends BaseViewModel {
  final ISearchChapterMeetingService _searchChapterMeetingService;
  SearchChapterMeetingViewModel(this._searchChapterMeetingService);

  bool _hasMore = true;
  DocumentSnapshot? _lastDocument;
  final List<Map<String, dynamic>> _publishedAnnouncements = [];
  // Getters
  bool get hasMore => _hasMore;
  List<Map<String, dynamic>> get publishedAnnouncements =>
      _publishedAnnouncements;

  Future<void> fetchItems() async {
    if (super.loading || !_hasMore) return;
    setLoading(loading: true);
    List<DocumentSnapshot> documents = [];
    await _searchChapterMeetingService
        .getPublishedAllAnnouncements(
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

    _publishedAnnouncements.addAll(
        documents.map((e) => e.data() as Map<String, dynamic>).toList());
    setLoading(loading: false);
  }

  Future<void> searchByClubUsername({required String clubUsername}) async {
    setLoading(loading: true);
    List<DocumentSnapshot> documents = [];
    await _searchChapterMeetingService
        .searchForClubAnnouncement(clubUsername: clubUsername)
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
