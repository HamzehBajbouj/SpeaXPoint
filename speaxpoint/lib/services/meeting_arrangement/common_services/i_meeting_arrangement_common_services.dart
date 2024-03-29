import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/models/allocated_role_player.dart';
import 'package:speaxpoint/models/toastmaster.dart';
import 'package:speaxpoint/models/volunteer_slot.dart';
import 'package:speaxpoint/services/Failure.dart';

abstract class IMeetingArrangementCommonServices {
  Future<Result<List<Toastmaster>, Failure>> getAllClubMembersList(
      String clubId);

  Stream<List<AllocatedRolePlayer>> getAllAllocatedRolePlayers(
      String chapterMeetingId);

  Stream<List<VolunteerSlot>> getVolunteersSlots(String chapterMeetingId);

  Future<Result<List<AllocatedRolePlayer>, Failure>>
      getAllAllocatedRolePlayersList(String chapterMeetingId);

  Future<CollectionReference> getAllocatedRolePlayerCollectionRef(
      String chapterMeetingId);

  Future<CollectionReference> getMeetingAgendaCollectionRef(
      String chapterMeetingId);

  Future<CollectionReference> getVolunteersSlotsCollectionRef(
      String chapterMeetingId);
}
