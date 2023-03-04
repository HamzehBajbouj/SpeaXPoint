import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/services/Failure.dart';
import 'package:speaxpoint/services/authentication/i_authentication_service.dart';

class AuthenticationFirebaseService extends IAuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final CollectionReference _clubAccountCollection =
      FirebaseFirestore.instance.collection('ClubAccounts');

  UserCredential? _userCredential;

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
                  .where("userId", isEqualTo: _auth.currentUser?.uid)
                  .get();

          if (checkUserHasExitedUserNameQuery.docs.isEmpty) {
            _clubAccountCollection
                .add({"userId": _auth.currentUser?.uid, "username": username});
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
      await _auth.createUserWithEmailAndPassword(
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
      {required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
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
}
