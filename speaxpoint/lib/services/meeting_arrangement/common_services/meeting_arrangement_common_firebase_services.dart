import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:speaxpoint/models/allocated_role_player.dart';
import 'package:speaxpoint/models/toastmaster.dart';
import 'package:speaxpoint/models/volunteer_slot.dart';
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
            message: e.message ?? "Database Error While get club members"),
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
    // the collection name must be an empty otherwise we will get an error
    CollectionReference allocatedRolePlayerCollection =
        FirebaseFirestore.instance.collection(" ");
    try {
      QuerySnapshot chapterMeetingQS = await _chapterMeetingsCollection
          .where("chapterMeetingId", isEqualTo: chapterMeetingId)
          .get();
      if (chapterMeetingQS.docs.isNotEmpty) {
        allocatedRolePlayerCollection = chapterMeetingQS.docs.first.reference
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
  Future<CollectionReference> getVolunteersSlotsCollectionRef(
      String chapterMeetingId) async {
    // the collection name must be an empty otherwise we will get an error
    CollectionReference volunteersSlots =
        FirebaseFirestore.instance.collection("VolunteersSlots");
    try {
      QuerySnapshot chapterMeetingQS = await _chapterMeetingsCollection
          .where("chapterMeetingId", isEqualTo: chapterMeetingId)
          .get();
      if (chapterMeetingQS.docs.isNotEmpty) {
        volunteersSlots =
            chapterMeetingQS.docs.first.reference.collection("VolunteersSlots");
      } else {
        throw Exception(
            "There are no matching record for chapter meeting with ID ${chapterMeetingId}");
      }
      return volunteersSlots;
    } catch (e) {
      return volunteersSlots;
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
    // the collection name must be an empty otherwise we will get an error
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

  @override
  Future<Result<List<AllocatedRolePlayer>, Failure>>
      getAllAllocatedRolePlayersList(String chapterMeetingId) async {
    try {
      List<AllocatedRolePlayer> allocatedRolePlayersList = [];
      QuerySnapshot ChapterMeetingQS = await _chapterMeetingsCollection
          .where("chapterMeetingId", isEqualTo: chapterMeetingId)
          .get();

      if (ChapterMeetingQS.docs.isNotEmpty) {
        CollectionReference allocatedRolePlayerCollection = ChapterMeetingQS
            .docs.first.reference
            .collection("AllocatedRolePlayers");
        QuerySnapshot allocatedPlayerSQ =
            await allocatedRolePlayerCollection.get();
        if (allocatedPlayerSQ.docs.isNotEmpty) {
          allocatedRolePlayersList = allocatedPlayerSQ.docs
              .map((doc) => AllocatedRolePlayer.fromJson(
                  doc.data() as Map<String, dynamic>))
              .toList();
        }
      } else {
        return Error(
          Failure(
              code: "No-Chapter-Meeting-Is-Found",
              location:
                  "MeetingArrangementCommonFirebaseServices.getAllAllocatedRolePlayersList()",
              message:
                  "there are no matching record for chapter meeting with ID ${chapterMeetingId}"),
        );
      }
      return Success(allocatedRolePlayersList);
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location:
                "MeetingArrangementCommonFirebaseServices.getAllAllocatedRolePlayersList()",
            message: e.message ??
                "Database Error While getting allocated role players details"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location:
                "MeetingArrangementCommonFirebaseServices.getAllAllocatedRolePlayersList()",
            message: e.toString()),
      );
    }
  }

  @override
  Stream<List<VolunteerSlot>> getVolunteersSlots(
      String chapterMeetingId) async* {
    Stream<List<VolunteerSlot>> volunteersSlots = const Stream.empty();
    try {
      var collectionReference =
          await getVolunteersSlotsCollectionRef(chapterMeetingId);
      volunteersSlots = collectionReference.snapshots().map(
            (QuerySnapshot querySnapshot) => querySnapshot.docs.map(
              (e) {
                return VolunteerSlot.fromJson(e.data() as Map<String, dynamic>);
              },
            ).toList(),
          );

      yield* volunteersSlots;
    } catch (e) {
      log(e.toString());
      yield* volunteersSlots;
    }
  }
}
