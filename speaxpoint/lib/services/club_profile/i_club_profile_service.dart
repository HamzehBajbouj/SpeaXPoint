import 'dart:io';
import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/models/club_account.dart';
import 'package:speaxpoint/services/failure.dart';

abstract class IClubProfileService {
  Future<Result<Unit, Failure>> updateClubProfileData({
    required String clubId,
    required ClubAccount clubAccount,
    File? profilePhoto,
    File? profileBackground,
  });

  Future<Result<ClubAccount, Failure>> getClubProfileData(
      {required String clubId});
}
