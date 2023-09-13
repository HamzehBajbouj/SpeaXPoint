import 'package:speaxpoint/services/failure.dart';
import 'package:multiple_result/src/result.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:speaxpoint/services/statistics/i_statistics_service.dart';

class StatisticsFirebaseService extends IStatisticsService {
  final CollectionReference _chapterMeetingsC =
      FirebaseFirestore.instance.collection('ChapterMeetings');

  final CollectionReference _onlineSessionCapturedDataC =
      FirebaseFirestore.instance.collection('OnlineSessionCapturedData');

  @override
  Future<Result<Map<String, List<DocumentSnapshot>>, Failure>>
      getListOfAllSpeechesSessions(
          {required String toastmasterId,
          int limit = 10,
          DocumentSnapshot<Object?>? startAfter}) async {
    Map<String, List<DocumentSnapshot>> documentMap = {};
    try {
      Query query = _onlineSessionCapturedDataC
          .where('toastmasterId', isEqualTo: toastmasterId)
          .orderBy("chapterMeetingId")
          .limit(limit);
      if (startAfter != null) {
        query = query.startAfterDocument(startAfter);
      }
      QuerySnapshot querySnapshot = await query.get();

      if (querySnapshot.docs.isNotEmpty) {
        documentMap["OnlineSessionCapturedData"] = querySnapshot.docs;
      }
      // Create a batch object
      List<DocumentReference> documentRefs = [];
      // Iterate through the documents and add queries to the batch
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        String chapterMeetingId = documentSnapshot['chapterMeetingId'];
        // Get the document reference
        DocumentReference docRef = _chapterMeetingsC.doc(chapterMeetingId);
        // Add the document reference to the list
        documentRefs.add(docRef);
      }

      List<Future<DocumentSnapshot>> futures =
          documentRefs.map((docRef) => docRef.get()).toList();

      List<DocumentSnapshot> chapterMeetingDocuments =
          await Future.wait(futures);

      if (chapterMeetingDocuments.isNotEmpty) {
        documentMap["ChapterMeetings"] = chapterMeetingDocuments;
      }

      return Success(documentMap);
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location:
                "StatisticsFirebaseService.getListOfAllSpeechesSessions()",
            message:
                e.message ?? "Database Error While fetching speech sessions"),
      );
    } catch (e) {
      return Error(
        Failure(
          code: e.toString(),
          location: "StatisticsFirebaseService.getListOfAllSpeechesSessions()",
          message: e.toString(),
        ),
      );
    }
  }
}
