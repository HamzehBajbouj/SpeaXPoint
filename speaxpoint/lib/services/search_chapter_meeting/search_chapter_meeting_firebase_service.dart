import 'package:speaxpoint/models/club_account.dart';
import 'package:speaxpoint/services/failure.dart';
import 'package:multiple_result/src/result.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:speaxpoint/services/search_chapter_meeting/i_search_chapter_meeting_service.dart';
import 'package:speaxpoint/util/constants/common_enums.dart';

class SearchChapterMeetingFirebaseService
    implements ISearchChapterMeetingService {
  final CollectionReference _clubAccounts =
      FirebaseFirestore.instance.collection('ClubAccounts');
  final CollectionReference _announcementCollection =
      FirebaseFirestore.instance.collection("Announcements");
  @override
  Future<Result<List<DocumentSnapshot>, Failure>> getPublishedAllAnnouncements(
      {int limit = 10, DocumentSnapshot? startAfter}) async {
    try {
      Query query = _announcementCollection
          .where('annoucementLevel', isEqualTo: AnnouncementLevel.Public.name)
          .orderBy('annoucementDate', descending: true)
          .limit(limit);
      if (startAfter != null) {
        query = query.startAfterDocument(startAfter);
      }
      QuerySnapshot querySnapshot = await query.get();
      return Success(querySnapshot.docs);
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location:
                "SearchChapterMeetingFirebaseService.getPublishedAllAnnouncements()",
            message: e.message ??
                "Database Error While fetching published announcements"),
      );
    } catch (e) {
      return Error(
        Failure(
          code: e.toString(),
          location:
              "SearchChapterMeetingFirebaseService.getPublishedAllAnnouncements()",
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Result<List<DocumentSnapshot>, Failure>> searchForClubAnnouncement(
      {required String clubUsername}) async {
    try {
      List<DocumentSnapshot> documents = [];
      QuerySnapshot clubQS =
          await _clubAccounts.where('username', isEqualTo: clubUsername).get();

      if (clubQS.docs.isNotEmpty) {
        ClubAccount clubAccount = ClubAccount.fromJson(
            clubQS.docs.first.data() as Map<String, dynamic>);
        QuerySnapshot announcementQS = await _announcementCollection
            .where('clubId', isEqualTo: clubAccount.clubId)
            .where('annoucementLevel', isEqualTo: AnnouncementLevel.Public.name)
            .get();
        documents = announcementQS.docs;
      }

      return Success(documents);
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location:
                "SearchChapterMeetingFirebaseService.getPublishedAllAnnouncements()",
            message: e.message ??
                "Database Error While fetching published announcements"),
      );
    } catch (e) {
      return Error(
        Failure(
          code: e.toString(),
          location:
              "SearchChapterMeetingFirebaseService.getPublishedAllAnnouncements()",
          message: e.toString(),
        ),
      );
    }
  }
}
