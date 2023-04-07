import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:speaxpoint/models/toastmaster.dart';
import 'package:speaxpoint/services/Failure.dart';
import 'package:multiple_result/src/result.dart';
import 'package:speaxpoint/services/meeting_arrangement/common_services/i_meeting_arrangement_common_services.dart';

class MeetingArrangementCommonFirebaseServices
    extends IMeetingArrangementCommonServices {
  final CollectionReference _toastmasterCollection =
      FirebaseFirestore.instance.collection("Toastmasters");
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
}
