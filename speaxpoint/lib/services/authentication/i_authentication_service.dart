import 'package:firebase_auth/firebase_auth.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/services/Failure.dart';

abstract class IAuthenticationService {
  UserCredential? get userCredential => null;
  Future<Result<Unit, Failure>> signIn(
      {required String email,
      required String password,
      required String userRole});

  Future<Result<Unit, Failure>> signInAnonymously();

  Future<Result<Unit, Failure>> signOut();

  Future<Result<Unit, Failure>> registerNewClub({
    required String email,
    required String password,
  });

  Future<Result<Unit, Failure>> registerClubUserName(
      {required String username});

  Future<Result<Unit, Failure>> validateGuestChapterMeetingInvitationCode({
    required String chapterMeetingInvitationCode,
  });

  Future<Result<Unit, Failure>> validateGuestRoleInvitationCode({
    required String chapterMeetingInvitationCode,
    required String roleInvitationCode,
  });
}
