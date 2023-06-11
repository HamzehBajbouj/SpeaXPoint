import 'dart:io';
import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/models/club_account.dart';
import 'package:speaxpoint/services/club_profile/i_club_profile_service.dart';
import 'package:speaxpoint/services/failure.dart';
import 'package:speaxpoint/view_models/base_view_mode.dart';

class ClubProfileViewModel extends BaseViewModel {
  final IClubProfileService _clubProfileService;

  ClubProfileViewModel(this._clubProfileService);

  Future<Result<Unit, Failure>> updateClubProfileDetails({
    required String clubName,
    required String profileDescription,
    required String overviewTitle,
    required String overviewDescription,
    required String contactNumber,
    required String officialEmail,
    String? locationLink,
    String? websiteLink,
    File? profilePhoto,
    File? profileBackground,
  }) async {
    String clubId = await super.getDataFromLocalDataBase(keySearch: "clubId");
    ClubAccount clubAccount = ClubAccount(
      clubId: clubId,
      clubName: clubName,
      profileDescription: profileDescription,
      clubOverviewTitle: overviewTitle,
      clubOverviewDescription: overviewDescription,
      clubPhoneNumber: contactNumber,
      officialEmail: officialEmail,
      clubLocationLink: locationLink,
      webSiteLink: websiteLink,
      clubProfileWasSetUp: true,
    );
    return await _clubProfileService.updateClubProfileData(
      clubId: clubId,
      clubAccount: clubAccount,
      profileBackground: profileBackground,
      profilePhoto: profilePhoto,
    );
  }

  Future<ClubAccount?> getClubDetails(
      {String? clubId, required bool getClubIdFromLocalDatabase}) async {
    ClubAccount? clubAccount;
    if (getClubIdFromLocalDatabase) {
      String clubIdTemp =
          await super.getDataFromLocalDataBase(keySearch: "clubId");
      await _clubProfileService
          .getClubProfileData(
        clubId: clubIdTemp,
      )
          .then(
        (value) {
          value.whenSuccess(
            (success) {
              clubAccount = success;
            },
          );
        },
      );
    } else {
      await _clubProfileService
          .getClubProfileData(
        clubId: clubId!,
      )
          .then(
        (value) {
          value.whenSuccess(
            (success) {
              clubAccount = success;
            },
          );
        },
      );
    }
    return clubAccount;
  }
}
