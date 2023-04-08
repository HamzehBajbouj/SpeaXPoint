import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:speaxpoint/models/allocated_role_player.dart';
import 'package:speaxpoint/models/toastmaster.dart';
import 'package:speaxpoint/services/Failure.dart';
import 'package:multiple_result/src/result.dart';
import 'package:speaxpoint/services/meeting_arrangement/common_services/i_meeting_arrangement_common_services.dart';

class MeetingArrangementCommonFirebaseServices
    extends IMeetingArrangementCommonServices {
  final CollectionReference _toastmasterCollection =
      FirebaseFirestore.instance.collection("Toastmasters");

  final CollectionReference _chapterMeetingsCollection =
      FirebaseFirestore.instance.collection('ChapterMeetings');
  @override
  Future<Result<List<Toastmaster>, Failure>> getAllClubMembersList(
      String clubId) async {
    try {
      List<Toastmaster> clubMemberList = [];

      QuerySnapshot querySnapshot =
          await _toastmasterCollection.where("clubId", isEqualTo: clubId).get();
      if (querySnapshot.docs.isNotEmpty) {
        clubMemberList = querySnapshot.docs
            .map((doc) =>
                Toastmaster.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
      } else {
        return const Error(
          Failure(
              code: 'no-members-are-found',
              location: "ManageClubMembersFirebaseService.getAllClubMembers()",
              message: "no members are found of this club"),
        );
      }
      return Success(clubMemberList);
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location:
                "MeetingArrangementCommonFirebaseServices.getAllClubMembers()",
            message: e.message ??
                "Database Error While creating a new meeting agneda"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location:
                "MeetingArrangementCommonFirebaseServices.getAllClubMembers()",
            message: e.toString()),
      );
    }
  }

  @override
  Future<CollectionReference> getAllocatedRolePlayerCollectionRef(
      String chapterMeetingId) async {
    CollectionReference allocatedRolePlayerCollection =
        FirebaseFirestore.instance.collection(" ");
    try {
      QuerySnapshot ChapterMeetingQS = await _chapterMeetingsCollection
          .where("chapterMeetingId", isEqualTo: chapterMeetingId)
          .get();
      if (ChapterMeetingQS.docs.isNotEmpty) {
        allocatedRolePlayerCollection = ChapterMeetingQS.docs.first.reference
            .collection("AllocatedRolePlayers");
      } else {
        throw Exception(
            "There are no matching record for chapter meeting with ID ${chapterMeetingId}");
      }
      return allocatedRolePlayerCollection;
    } catch (e) {
      return allocatedRolePlayerCollection;
    }
  }

  @override
  Stream<List<AllocatedRolePlayer>> getAllAllocatedRolePlayers(
      String chapterMeetingId) async* {
    Stream<List<AllocatedRolePlayer>> allocatedRolePlayer =
        const Stream.empty();
    try {
      var collectionReference =
          await getAllocatedRolePlayerCollectionRef(chapterMeetingId);
      allocatedRolePlayer = collectionReference.snapshots().map(
            (QuerySnapshot querySnapshot) => querySnapshot.docs.map(
              (e) {
                return AllocatedRolePlayer.fromJson(
                    e.data() as Map<String, dynamic>);
              },
            ).toList(),
          );

      yield* allocatedRolePlayer;
    } catch (e) {
      log(e.toString());
      yield* allocatedRolePlayer;
    }
  }

  @override
  Future<CollectionReference<Object?>> getMeetingAgendaCollectionRef(
      String chapterMeetingId) async {
    CollectionReference allocatedRolePlayerCollection =
        FirebaseFirestore.instance.collection(" ");
    try {
      QuerySnapshot ChapterMeetingQS = await _chapterMeetingsCollection
          .where("chapterMeetingId", isEqualTo: chapterMeetingId)
          .get();
      if (ChapterMeetingQS.docs.isNotEmpty) {
        allocatedRolePlayerCollection =
            ChapterMeetingQS.docs.first.reference.collection("MeetingAgenda");
      } else {
        throw Exception(
            "there are no matching record for chapter meeting with ID ${chapterMeetingId}");
      }
      return allocatedRolePlayerCollection;
    } catch (e) {
      return allocatedRolePlayerCollection;
    }
  }
}
