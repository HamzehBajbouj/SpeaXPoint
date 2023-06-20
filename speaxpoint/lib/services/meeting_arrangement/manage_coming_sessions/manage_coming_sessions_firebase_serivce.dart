import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:speaxpoint/models/chapter_meeting.dart';
import 'package:speaxpoint/services/Failure.dart';
import 'package:multiple_result/src/unit.dart';
import 'package:multiple_result/src/result.dart';
import 'package:speaxpoint/services/meeting_arrangement/manage_coming_sessions/i_manage_coming_sessions_service.dart';

class ManageComingSessionsFirebaseSerivce extends IManageComingSessionsService {
  final CollectionReference _chapterMeetingsCollection =
      FirebaseFirestore.instance.collection('ChapterMeetings');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<Result<Unit, Failure>> createNewSession(
    ChapterMeeting chapterMeeting,
  ) async {
    try {
      if (_auth.currentUser != null) {
        /*
        make sure to assign the correct user id of the current logged in user.
        the one that is passed from the parameter might not be updated up to date,
        since it's fetched from the sharedPreferences
        */
        chapterMeeting.toastmasterId = _auth.currentUser!.uid;
        await _chapterMeetingsCollection
            .doc(chapterMeeting.chapterMeetingId)
            .set(chapterMeeting.toJson());
      } else {
        return const Error(
          Failure(
              code: "Not-Logged-In-User",
              location:
                  "ManageComingSessionsFirebaseSerivce.createNewSession()",
              message:
                  "You are trying to create a session, while you are not logged into your account in the app"),
        );
      }

      return Success.unit();
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location: "ManageComingSessionsFirebaseSerivce.createNewSession()",
            message:
                e.message ?? "Database Error While creating a new session"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location: "ManageComingSessionsFirebaseSerivce.createNewSession()",
            message: e.toString()),
      );
    }
  }

  @override
  Stream<List<ChapterMeeting>> getAllComingSessions() {
    Stream<List<ChapterMeeting>> chapteMeetings = const Stream.empty();
    try {
      if (_auth.currentUser != null) {
        chapteMeetings = _chapterMeetingsCollection
            .where("toastmasterId", isEqualTo: _auth.currentUser!.uid)
            .snapshots()
            .map(
              (QuerySnapshot querySnapshot) => querySnapshot.docs.map(
                (e) {
                  return ChapterMeeting.fromJson(
                      e.data() as Map<String, dynamic>);
                },
              ).toList(),
            );
      }
      return chapteMeetings;
    } catch (e) {
      log(e.toString());
      return chapteMeetings;
    }
  }
}
