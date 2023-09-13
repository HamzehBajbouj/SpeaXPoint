import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/services/failure.dart';

abstract class ISearchChapterMeetingService {
  Future<Result<List<DocumentSnapshot>, Failure>> getPublishedAllAnnouncements({
    required String clubId,
    int limit = 10,
    DocumentSnapshot? startAfter,
  });

  Future<Result<List<DocumentSnapshot>, Failure>> searchForClubAnnouncement({
    required String searchClubUsername,
    required String userClubId
  });
}
