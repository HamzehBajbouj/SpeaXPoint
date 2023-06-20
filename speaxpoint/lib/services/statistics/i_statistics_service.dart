import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/services/failure.dart';

//it must return two elements for each index, 1 the role name of the toastmasert and his order.
//2 is the chapterMeetingObject
abstract class IStatisticsService {
  Future<Result<Map<String, List<DocumentSnapshot>>, Failure>>
      getListOfAllSpeechesSessions({
    required String toastmasterId,
    int limit = 10,
    DocumentSnapshot? startAfter,
  });
}
