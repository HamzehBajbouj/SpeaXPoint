import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/models/allocated_role_player.dart';
import 'package:speaxpoint/models/chapter_meeting.dart';
import 'package:speaxpoint/services/meeting_arrangement/common_services/meeting_arrangement_common_firebase_services.dart';
import 'package:speaxpoint/services/session_redirection/i_session_redirection_service.dart';

import '../failure.dart';

class SessionRedirectionFirebaseService extends ISessionRedirectionService {
  final CollectionReference _chapterMeetingsCollection =
      FirebaseFirestore.instance.collection("ChapterMeetings");
  @override
  Future<Result<String, Failure>> getAppGuestRoleName({
    required String chapterMeetingInvitationCode,
    required String guestInvitationCode,
  }) async {
    try {
      QuerySnapshot chMeetingQS = await _chapterMeetingsCollection
          .where("invitationCode", isEqualTo: chapterMeetingInvitationCode)
          .get();

      if (chMeetingQS.docs.isNotEmpty) {
        CollectionReference allocatedRolePlayerCollection =
            chMeetingQS.docs.first.reference.collection("AllocatedRolePlayers");
        QuerySnapshot allocatedRPQS = await allocatedRolePlayerCollection
            .where("guestInvitationCode", isEqualTo: guestInvitationCode)
            .get();
        if (allocatedRPQS.docs.isEmpty) {
          return Error(
            Failure(
                code: "No-Matching-Guest-Invitation-Code",
                location:
                    "SessionRedirectionFirebaseService.getAppGuestRoleName()",
                message:
                    "Could not find any guest allocated role player with invitation code: $guestInvitationCode"),
          );
        } else {
          AllocatedRolePlayer allocatedRolePlayer =
              AllocatedRolePlayer.fromJson(
                  allocatedRPQS.docs.first.data() as Map<String, dynamic>);
          return Success(allocatedRolePlayer.roleName!);
        }
      } else {
        return Error(
          Failure(
              code: "No-Chapter-Meeting-Found",
              location:
                  "SessionRedirectionFirebaseService.getAppGuestRoleName()",
              message:
                  "Could not find the chapter meeting with Invitation code : $chapterMeetingInvitationCode"),
        );
      }
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location: "SessionRedirectionFirebaseService.getAppGuestRoleName()",
            message:
                e.message ?? "Database Error While fetching guest role name"),
      );
    } catch (e) {
      return Error(
        Failure(
          code: e.toString(),
          location: "SessionRedirectionFirebaseService.getAppGuestRoleName()",
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Result<String, Failure>> getAppUserRoleName({
    required String chapterMeetingId,
    required String toastmasterId,
  }) async {
    try {
      QuerySnapshot chMeetingQS = await _chapterMeetingsCollection
          .where("chapterMeetingId", isEqualTo: chapterMeetingId)
          .get();
      if (chMeetingQS.docs.isNotEmpty) {
        CollectionReference allocatedRolePlayerCollection =
            chMeetingQS.docs.first.reference.collection("AllocatedRolePlayers");
        QuerySnapshot allocatedRPQS = await allocatedRolePlayerCollection
            .where("toastmasterId", isEqualTo: toastmasterId)
            .get();
        if (allocatedRPQS.docs.isEmpty) {
          return Error(
            Failure(
                code: "No-Matching-Toastmaster-ID",
                location:
                    "SessionRedirectionFirebaseService.getAppUserRoleName()",
                message:
                    "Could not find any allocated role player with toastmaster Id: $toastmasterId"),
          );
        } else {
          AllocatedRolePlayer allocatedRolePlayer =
              AllocatedRolePlayer.fromJson(
                  allocatedRPQS.docs.first.data() as Map<String, dynamic>);
          return Success(allocatedRolePlayer.roleName!);
        }
      } else {
        return Error(
          Failure(
              code: "No-Chapter-Meeting-Found",
              location:
                  "SessionRedirectionFirebaseService.getAppUserRoleName()",
              message:
                  "Could not find the chapter meeting with chapter meeting id: $chapterMeetingId"),
        );
      }
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location: "SessionRedirectionFirebaseService.getAppUserRoleName()",
            message: e.message ??
                "Database Error While fetching app allocated role player role name"),
      );
    } catch (e) {
      return Error(
        Failure(
          code: e.toString(),
          location: "SessionRedirectionFirebaseService.getAppGuestRoleName()",
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Result<Unit, Failure>> leaveTheChapterMeetingSessionAppUser(
      {required String chapterMeetingId}) async {
    try {
      QuerySnapshot chapterMeetingQS = await _chapterMeetingsCollection
          .where("chapterMeetingId", isEqualTo: chapterMeetingId)
          .get();
      if (chapterMeetingQS.docs.isNotEmpty) {
        CollectionReference onlineSessionCollectoin =
            chapterMeetingQS.docs.first.reference.collection("OnlineSession");

        QuerySnapshot onlineSessionQS = await onlineSessionCollectoin.get();
        if (onlineSessionQS.docs.isNotEmpty) {
          Map<String, dynamic> onlineSessionData =
              onlineSessionQS.docs.first.data() as Map<String, dynamic>;

          int numberOfJoinedPeople = onlineSessionData["numberOfJoinedPeople"];
          await onlineSessionQS.docs.first.reference.update(
            {"numberOfJoinedPeople": numberOfJoinedPeople -= 1},
          );
        }
      } else {
        return Error(
          Failure(
              code: "No-Chapter-Meeting-Found",
              location:
                  "SessionRedirectionFirebaseService.leaveTheChapterMeetingSessionAppUser()",
              message:
                  "Could not found a chapter meeting with id : $chapterMeetingId"),
        );
      }
      return Success.unit();
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location:
                "SessionRedirectionFirebaseService.leaveTheChapterMeetingSessionAppUser()",
            message: e.message ??
                "Database Error While leaving the scheduled meeting"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location:
                "SessionRedirectionFirebaseService.leaveTheChapterMeetingSessionAppUser()",
            message: e.toString()),
      );
    }
  }

  @override
  Future<Result<Unit, Failure>> leaveTheChapterMeetingSessionGuestUser(
      {required String chapterMeetingInvitationCode}) async {
    try {
      QuerySnapshot chapterMeetingQS = await _chapterMeetingsCollection
          .where("invitationCode", isEqualTo: chapterMeetingInvitationCode)
          .get();
      if (chapterMeetingQS.docs.isNotEmpty) {
        CollectionReference onlineSessionCollectoin =
            chapterMeetingQS.docs.first.reference.collection("OnlineSession");

        QuerySnapshot onlineSessionQS = await onlineSessionCollectoin.get();
        if (onlineSessionQS.docs.isNotEmpty) {
          Map<String, dynamic> onlineSessionData =
              onlineSessionQS.docs.first.data() as Map<String, dynamic>;

          int numberOfJoinedPeople = onlineSessionData["numberOfJoinedPeople"];
          await onlineSessionQS.docs.first.reference.update(
            {"numberOfJoinedPeople": numberOfJoinedPeople -= 1},
          );
        }
      } else {
        return Error(
          Failure(
              code: "No-Chapter-Meeting-Found",
              location:
                  "SessionRedirectionFirebaseService.leaveTheChapterMeetingSessionGuestUser()",
              message:
                  "Could not found a chapter meeting with invitation code : $chapterMeetingInvitationCode"),
        );
      }
      return Success.unit();
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location:
                "SessionRedirectionFirebaseService.leaveTheChapterMeetingSessionGuestUser()",
            message: e.message ??
                "Database Error While leaving the scheduled meeting"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location:
                "SessionRedirectionFirebaseService.leaveTheChapterMeetingSessionGuestUser()",
            message: e.toString()),
      );
    }
  }

  @override
  Stream<ChapterMeeting> getChapterMeetingLiveDataDetails(
      {required bool isAppGuest,
      String? chapterMeetingId,
      String? chapterMeetingInvitationCode}) async* {
    Stream<ChapterMeeting> chapterMeeting = Stream.empty();
    try {
      if (isAppGuest) {
        chapterMeeting = _chapterMeetingsCollection
            .where("invitationCode", isEqualTo: chapterMeetingInvitationCode)
            .limit(1) // Retrieve only the first document
            .snapshots()
            .map((QuerySnapshot querySnapshot) => ChapterMeeting.fromJson(
                querySnapshot.docs[0].data() as Map<String, dynamic>));
      } else {
        chapterMeeting = _chapterMeetingsCollection
            .where("chapterMeetingId", isEqualTo: chapterMeetingId)
            .limit(1) // Retrieve only the first document
            .snapshots()
            .map((QuerySnapshot querySnapshot) => ChapterMeeting.fromJson(
                querySnapshot.docs[0].data() as Map<String, dynamic>));
      }

      yield* chapterMeeting;
    } on FirebaseException catch (e) {
      log("${e.code} ${e.message}");
      yield* chapterMeeting;
    } catch (e) {
      log(e.toString());
      yield* chapterMeeting;
    }
  }
}
