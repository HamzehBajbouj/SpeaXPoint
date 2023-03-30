import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:speaxpoint/services/Failure.dart';
import 'package:speaxpoint/models/toast_master.dart';
import 'package:multiple_result/src/unit.dart';
import 'package:multiple_result/src/result.dart';
import 'package:speaxpoint/services/manage_club_members/i_manage_club_members_service.dart';

class ManageClubMembersFirebaseService extends IManageClubMembersService {
  final CollectionReference _toastmasterCollection =
      FirebaseFirestore.instance.collection('Toastmasters');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<Result<List<Toastmaster>, Failure>> getAllClubMembers() async {
    List<Toastmaster> clubMembersList = [];
    try {
      QuerySnapshot clubMembers = await _toastmasterCollection
          .where("clubId", isEqualTo: _auth.currentUser?.uid)
          .get();

      if (clubMembers.docs.isNotEmpty) {
        clubMembersList = clubMembers.docs
            .map((doc) =>
                Toastmaster.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
      } else {
        return const Error(
          Failure(
              code: 'no=members-are-found',
              location: "ManageClubMembersFirebaseService.getAllClubMembers()",
              message: "no members are found of this club"),
        );
      }

      return Success(clubMembersList);
    } on FirebaseAuthException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location: "ManageClubMembersFirebaseService.getAllClubMembers()",
            message: e.message ?? "Database Error While getting club members"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location: "ManageClubMembersFirebaseService.getAllClubMembers()",
            message: e.toString()),
      );
    }
  }

  @override
  Future<Result<Unit, Failure>> registerNewMember(
      String email, String password, Toastmaster toastmaster) async {
    FirebaseApp app = await Firebase.initializeApp(
        name: 'Secondary', options: Firebase.app().options);
    try {
      await FirebaseAuth.instanceFor(app: app)
          .createUserWithEmailAndPassword(email: email, password: password)
          .then(
        (value) {
          if (value.user != null) {
            _toastmasterCollection.add(
              {
                'toastmasterId': value.user!.uid,
                'clubId': toastmaster.clubId,
                'toastmasterName': toastmaster.toastmasterName,
                'currentPath': toastmaster.currentPath,
                'currentProject': toastmaster.currentProject,
                'currentLevel': toastmaster.currentLevel,
                'toastmasterBirthDate': toastmaster.toastmasterBirthDate,
                'gender': toastmaster.gender,
                'memberOfficalRole': toastmaster.memberOfficalRole,
                'toastmasterImage': toastmaster.toastmasterImage
              },
            );
          } else {
            return const Error(
              Failure(
                  code: "user is null",
                  location:
                      "ManageClubMembersFirebaseService.registerNewMember()",
                  message: "Database Error While Registration"),
            );
          }
        },
      );
      await app.delete();
      return Success.unit();
    } on FirebaseAuthException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location: "ManageClubMembersFirebaseService.registerNewMember()",
            message: e.message ?? "Database Error While adding new member"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location: "ManageClubMembersFirebaseService.registerNewMember()",
            message: e.toString()),
      );
    }
  }

  @override
  Future<Result<Unit, Failure>> updateMemberDetails(
      Toastmaster toastmaster) async {
    try {
      QuerySnapshot checkUserHasExitedDocument = await _toastmasterCollection
          .where("toastmasterId", isEqualTo: toastmaster.toastmasterId)
          .get();

      if (checkUserHasExitedDocument.docs.isNotEmpty) {
        //since each user will have only on 1 document always get the first document
        checkUserHasExitedDocument.docs.first.reference.update(
          {
            'toastmasterName': toastmaster.toastmasterName,
            'currentPath': toastmaster.currentPath,
            'currentProject': toastmaster.currentProject,
            'currentLevel': toastmaster.currentLevel,
            'toastmasterBirthDate': toastmaster.toastmasterBirthDate,
            'gender': toastmaster.gender,
            'memberOfficalRole': toastmaster.memberOfficalRole,
            'toastmasterImage': toastmaster.toastmasterImage,
          },
        );
      } else {
        return const Error(
          Failure(
              code: "no-existed-member",
              message: "no member record cannot be found in the database.",
              location:
                  "ManageClubMembersFirebaseService.updateMemberDetails()"),
        );
      }

      return Success.unit();
    } on FirebaseAuthException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location: "ManageClubMembersFirebaseService.updateMemberDetails()",
            message:
                e.message ?? "Database Error While updating member detials"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location: "ManageClubMembersFirebaseService.updateMemberDetails()",
            message: e.toString()),
      );
    }
  }

  @override
  Future<Result<Toastmaster, Failure>> getToastmasterDetails(
      String toastmasterId) async {
    try {
      Toastmaster toastmaster;
      QuerySnapshot checkUserHasExitedDocument = await _toastmasterCollection
          .where("toastmasterId", isEqualTo: toastmasterId)
          .get();

      if (checkUserHasExitedDocument.docs.isNotEmpty) {
        //since each user will have only on 1 document always get the first document

        toastmaster = Toastmaster.fromJson(
          checkUserHasExitedDocument.docs.first.data() as Map<String, dynamic>);
      } else {
        return const Error(
          Failure(
              code: "no-existed-member",
              message: "no member record cannot be found in the database.",
              location:
                  "ManageClubMembersFirebaseService.getToastmasterDetails()"),
        );
      }

      return Success(toastmaster);
    } on FirebaseAuthException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location:
"ManageClubMembersFirebaseService.getToastmasterDetails()",
            message:
                e.message ?? "Database Error While getting member detials"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location:
                "ManageClubMembersFirebaseService.getToastmasterDetails()",
            message: e.toString()),
      );
    }
  }
}
