import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/models/chapter_meeting.dart';
import 'package:speaxpoint/services/Failure.dart';
import 'package:speaxpoint/services/authentication/i_authentication_service.dart';
import 'package:speaxpoint/services/local_database/i_local_database_service.dart';
import 'package:speaxpoint/util/constants/common_enums.dart';
import 'package:speaxpoint/util/constants/shared_preferences_keys.dart';

class AuthenticationFirebaseService extends IAuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ILocalDataBaseService _localDataBaseSharedPreferences;

  final CollectionReference _toastmasterCollection =
      FirebaseFirestore.instance.collection('Toastmasters');

  final CollectionReference _clubAccountCollection =
      FirebaseFirestore.instance.collection('ClubAccounts');

  final CollectionReference _chapterMeetingsC =
      FirebaseFirestore.instance.collection('ChapterMeetings');

  UserCredential? _userCredential;

  AuthenticationFirebaseService(this._localDataBaseSharedPreferences);

  @override
  UserCredential? get userCredential => _userCredential;

  @override
  Future<Result<Unit, Failure>> registerClubUserName(
      {required String username}) async {
    try {
      QuerySnapshot querySnapshot = await _clubAccountCollection
          .where("username", isEqualTo: username)
          .get();

      if (querySnapshot.docs.isEmpty) {
        if (_auth.currentUser != null) {
          QuerySnapshot checkUserHasExitedUserNameQuery =
              await _clubAccountCollection
                  .where("clubId", isEqualTo: _auth.currentUser?.uid)
                  .get();

          if (checkUserHasExitedUserNameQuery.docs.isEmpty) {
            _clubAccountCollection.add({
              "clubId": _auth.currentUser?.uid,
              "username": username,
              "appRole": AppRoles.ClubPresident.name,
            });
          } else {
            return const Error(Failure(
                code: "username-existed",
                message:
                    "There is already registered username with your email.",
                location:
                    "AuthenticationFirebaseService.registerClubUserName"));
          }
        } else {
          return const Error(Failure(
              code: "current-user",
              message: "User is not logged in",
              location: "AuthenticationFirebaseService.registerClubUserName"));
        }
      } else {
        return const Error(Failure(
            code: "username-used",
            message: "The username is used",
            location: "AuthenticationFirebaseService.registerClubUserName"));
      }

      return Success.unit();
    } on FirebaseAuthException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location: "AuthenticationFirebaseService.registerClubUserName()",
            message: e.message ?? "Database Error While Registration"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location: "AuthenticationFirebaseService.registerClubUserName()",
            message: e.toString()),
      );
    }
  }

  @override
  Future<Result<Unit, Failure>> registerNewClub({
    required String email,
    required String password,
  }) async {
    try {
      _userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      return Success.unit();
    } on FirebaseAuthException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location: "AuthenticationFirebaseService.registerNewClub()",
            message: e.message ?? "Database Error While Registration"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location: "AuthenticationFirebaseService.registerNewClub()",
            message: e.toString()),
      );
    }
  }

  @override
  Future<Result<Unit, Failure>> signIn(
      {required String email,
      required String password,
      required String userRole}) async {
    try {
      _userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      //after logging in , check the role of the user and validate whether he has
      //the correct authorization or not, and then it save the user details locally
      // in the shared preferences
      if (_auth.currentUser != null) {
        QuerySnapshot querySnapshot = userRole == AppRoles.ClubPresident.name
            ? await _clubAccountCollection
                .where("clubId", isEqualTo: _auth.currentUser!.uid)
                .get()
            : await _toastmasterCollection
                .where("toastmasterId", isEqualTo: _auth.currentUser!.uid)
                .get();

        if (querySnapshot.docs.isEmpty) {
          return const Error(
            Failure(
                code: "User Has No record",
                location: "AuthenticationFirebaseService.signIn()",
                message:
                    "The user you are trying to log in with has no records registered"),
          );
        } else {
          Map<String, dynamic> userAccount =
              querySnapshot.docs.first.data() as Map<String, dynamic>;
          if (userRole == AppRoles.ClubPresident.name &&
              userAccount['appRole'] == AppRoles.ClubPresident.name) {
            await _localDataBaseSharedPreferences.saveData(
                SharedPrefereneceKeys.loggedUser, json.encode(userAccount));
            return Success.unit();
          } else if (userRole == AppRoles.Toastmaster.name &&
              userAccount['appRole'] == AppRoles.Toastmaster.name) {
            await _localDataBaseSharedPreferences.saveData(
                SharedPrefereneceKeys.loggedUser, json.encode(userAccount));
            return Success.unit();
          } else {
            return const Error(
              Failure(
                  code: "Un-Authorized-Access",
                  location: "AuthenticationFirebaseService.signIn()",
                  message: "You have an Un-Authorized-Access permssions"),
            );
          }
        }
      }

      return Success.unit();
    } on FirebaseAuthException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location: "AuthenticationFirebaseService.signIn()",
            message: e.message ?? "Database Error While Logging in"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location: "AuthenticationFirebaseService.signIn()",
            message: e.toString()),
      );
    }
  }

  @override
  Future<Result<Unit, Failure>> signOut() async {
    try {
      await _auth.signOut();
      return Success.unit();
    } on FirebaseAuthException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location: "AuthenticationFirebaseService.signIn()",
            message: e.message ?? "Database Error While Logging in"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location: "AuthenticationFirebaseService.registerNewClub()",
            message: e.toString()),
      );
    }
  }

  @override
  Future<Result<Unit, Failure>> signInAnonymously() async {
    try {
      _userCredential = await _auth.signInAnonymously();

      return Success.unit();
    } on FirebaseAuthException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location: "AuthenticationFirebaseService.signInAnonymously()",
            message:
                e.message ?? "Database Error While Logging in Anonymously"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location: "AuthenticationFirebaseService.signInAnonymously()",
            message: e.toString()),
      );
    }
  }

  @override
  Future<Result<Unit, Failure>> validateGuestChapterMeetingInvitationCode(
      {required String chapterMeetingInvitationCode}) async {
    try {
      QuerySnapshot chapterMeetingsQS = await _chapterMeetingsC
          .where("invitationCode", isEqualTo: chapterMeetingInvitationCode)
          .get();
      if (chapterMeetingsQS.docs.isNotEmpty) {
        ChapterMeeting chapterMeeting = ChapterMeeting.fromJson(
            chapterMeetingsQS.docs.first.data() as Map<String, dynamic>);
        if (chapterMeeting.chapterMeetingStatus !=
            ComingSessionsStatus.Ongoing.name) {
          return Error(
            Failure(
                code: "Session-Has-Not-Started",
                location:
                    "AuthenticationFirebaseService.validateGuestChapterMeetingInvitationCode()",
                message:
                    "The session with id : $chapterMeetingInvitationCode. has not started yet, please try in again later, or contact the VPE of the organizer club."),
          );
        } else {}
      } else {
        return Error(
          Failure(
              code: "No-Chapter-Meeting-Found",
              location:
                  "AuthenticationFirebaseService.validateGuestChapterMeetingInvitationCode()",
              message:
                  "There is no any chapter meeting with invitation code : $chapterMeetingInvitationCode"),
        );
      }
      return Success.unit();
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location:
                "AuthenticationFirebaseService.validateGuestChapterMeetingInvitationCode()",
            message: e.message ??
                "Database Error While Validating Chapter Meeting Invitation Code"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location:
                "AuthenticationFirebaseService.validateGuestChapterMeetingInvitationCode()",
            message: e.toString()),
      );
    }
  }

  @override
  Future<Result<Unit, Failure>> validateGuestRoleInvitationCode(
      {required String chapterMeetingInvitationCode,
      required String roleInvitationCode}) async {
    try {
      QuerySnapshot chapterMeetingsQS = await _chapterMeetingsC
          .where("invitationCode", isEqualTo: chapterMeetingInvitationCode)
          .get();
      //search in the AllocatedRolePlayers collection for the guest id
      CollectionReference allocatedRolePlayersC = chapterMeetingsQS
          .docs.first.reference
          .collection("AllocatedRolePlayers");
      QuerySnapshot allocatedRolePlayersQS = await allocatedRolePlayersC
          .where("allocatedRolePlayerType",
              isEqualTo: AllocatedRolePlayerType.Guest.name)
          .where("guestInvitationCode", isEqualTo: roleInvitationCode)
          .get();

      if (allocatedRolePlayersQS.docs.isEmpty) {
        return Error(
          Failure(
              code: "No-Guest-Role-Found",
              location:
                  "AuthenticationFirebaseService.validateGuestRoleInvitationCode()",
              message:
                  "The role invitation code $roleInvitationCode can not be found."),
        );
      }

      return Success.unit();
    } on FirebaseException catch (e) {
      return Error(
        Failure(
            code: e.code,
            location:
                "AuthenticationFirebaseService.validateGuestRoleInvitationCode()",
            message: e.message ??
                "Database Error While Validating Chapter Meeting Invitation Code"),
      );
    } catch (e) {
      return Error(
        Failure(
            code: e.toString(),
            location:
                "AuthenticationFirebaseService.validateGuestRoleInvitationCode()",
            message: e.toString()),
      );
    }
  }
}
