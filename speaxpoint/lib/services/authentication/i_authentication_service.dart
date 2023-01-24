import 'package:firebase_auth/firebase_auth.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/services/Failure.dart';

abstract class IAuthenticationService {
  UserCredential? get userCredential => null;
  Future<Result<Unit, Failure>> signIn(
      {required String email, required String password});

  Future<Result<Unit, Failure>> signOut();

  Future<Result<Unit, Failure>> registerNewClub({
    required String email,
    required String password,
  });

  Future<Result<Unit, Failure>> registerClubUserName(
      {required String username});
}
