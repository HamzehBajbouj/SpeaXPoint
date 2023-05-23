import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:speaxpoint/services/failure.dart';
import 'package:speaxpoint/models/chapter_meeting.dart';
import 'package:multiple_result/src/result.dart';
import 'package:speaxpoint/services/scheduled_meeting_management/i_scheduled_meeting_management_service.dart';

class ScheduledMeetingManagementFirebaseService
    extends IScheduledMeetingManagementService {
  final CollectionReference _allocatedPlayersQSC =
      FirebaseFirestore.instance.collection('AllocatedPlayersQuickSearch');
  final CollectionReference _chapterMeetingsC =
      FirebaseFirestore.instance.collection('ChapterMeetings');

  @override
  Future<Result<List<ChapterMeeting>, Failure>> getAllScheduledMeeting(
      {required String clubId, required String toastmasterId}) async {
    List<ChapterMeeting> chapterMeetingsList = [];
    List<String> listOfChapterMeetingIds = [];
    try {
      /*
      This part will search in the AllocatedPlayersQuickSearch collection to get 
      all the chapterMeeting where the members is assigned including the ones from
      different clubs (and this is the main purpose of it), then after we get the chapterMeetingId
      we serach in the ChapterMeetings collection to get the details of these meetings
      under the filtering condition that it must be Ongoing or Coming, the reason
      it's because the meeting was announced and all the preparation are done,
      we don't want to display the pending or the finished meetings.
      Note: if the member was not registered in any other club(or his club has no meeting) meeting, 
      the chapterMeetingsList will be empty after we finish from the first part
      */
      QuerySnapshot allocatedPlayersQS = await _allocatedPlayersQSC
          .where("toastmasterId", isEqualTo: toastmasterId)
          .get();

      if (allocatedPlayersQS.docs.isNotEmpty) {
        for (QueryDocumentSnapshot documentSnapshot
            in allocatedPlayersQS.docs) {
          var chapterMeetingId = documentSnapshot['chapterMeetingId'];
          listOfChapterMeetingIds.add(chapterMeetingId);
        }
      }
      if (listOfChapterMeetingIds.isNotEmpty) {
        /*
        the reason why we have these batches and why we are spliting the 
        listOfChapterMeetingIds into sub-lists, is because the "whereIn"
        can only accept an array of size 10 records 
        */
        List<List<String>> batches = [];
        // Split values into batches of 10 or fewer values
        for (int i = 0; i < listOfChapterMeetingIds.length; i += 10) {
          int endIndex = i + 10;
          if (endIndex > listOfChapterMeetingIds.length) {
            endIndex = listOfChapterMeetingIds.length;
          }
          List<String> batch = listOfChapterMeetingIds.sublist(i, endIndex);
          batches.add(batch);
        }
        for (List<String> batch in batches) {
          QuerySnapshot chapterMeetingQS = await _chapterMeetingsC
              .where("chapterMeetingId", whereIn: batch)
              .get();

          if (chapterMeetingQS.docs.isNotEmpty) {
            chapterMeetingsList.addAll(chapterMeetingQS.docs
                .map((doc) =>
                    ChapterMeeting.fromJson(doc.data() as Map<String, dynamic>))
                .toList());
          }
          /*
          we have to filter the results to only get the Coming & Ongoing, meetings
          //the reason why i don't do the filtering the query is because firestore
          doesn't allow Two "whereIn" in one query
          */
          chapterMeetingsList.removeWhere((element) =>
              element.chapterMeetingStatus != "Coming" &&
              element.chapterMeetingStatus != "Ongoing");
        }
      }
      /*
      Now this part will get all the coming chatperMeeting for the member but 
      within only his club(it will not get any of other clubs meeting details if it was registered, 
      because we already done that in the first step.), this might results in items
      duplication  in the chapterMeetingsList so we need to check that as well
      */
      QuerySnapshot chapterMeetingsQS = await _chapterMeetingsC
          .where("clubId", isEqualTo: clubId)
          .where("chapterMeetingStatus", whereIn: ["Coming", "Ongoing"]).get();
      if (chapterMeetingsQS.docs.isNotEmpty) {
        List<ChapterMeeting> tempChapterMeetingsList = chapterMeetingsQS.docs
            .map((doc) =>
                ChapterMeeting.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
        /*
        remove any duplication in the tempChapterMeetingsList, meaning
        it check if the item is existed in chapterMeetingsList, if so delete it
        from the list.
        */
        if (tempChapterMeetingsList.isNotEmpty) {
          tempChapterMeetingsList.removeWhere(
            (chapterMeeting) => chapterMeetingsList.any((element) =>
                chapterMeeting.chapterMeetingId == element.chapterMeetingId),
          );
          //then add all remaining to the chapterMeetingsList list
          chapterMeetingsList.addAll(tempChapterMeetingsList);
        }
      }
      return Success(chapterMeetingsList);
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location:
                "ScheduledMeetingManagementFirebaseService.getAllScheduledMeeting()",
            message:
                e.message ?? "Database Error While getting scheduled meetings"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location:
                "ScheduledMeetingManagementFirebaseService.getAllScheduledMeeting()",
            message: e.toString()),
      );
    }
  }
}
