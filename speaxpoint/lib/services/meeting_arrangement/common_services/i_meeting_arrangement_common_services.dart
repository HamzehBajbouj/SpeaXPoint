import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/models/allocated_role_player.dart';
import 'package:speaxpoint/models/toastmaster.dart';
import 'package:speaxpoint/services/Failure.dart';

abstract class IMeetingArrangementCommonServices {
  Future<Result<List<Toastmaster>, Failure>> getAllClubMembersList(
      String clubId);

  Stream<List<AllocatedRolePlayer>> getAllAllocatedRolePlayers(
      String chapterMeetingId);
  Future<CollectionReference> getAllocatedRolePlayerCollectionRef(
      String chapterMeetingId);
}
