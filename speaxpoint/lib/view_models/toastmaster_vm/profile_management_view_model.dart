import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/models/toastmaster.dart';
import 'package:speaxpoint/services/Failure.dart';
import 'package:speaxpoint/services/authentication/i_authentication_service.dart';
import 'package:speaxpoint/services/manage_club_members/i_manage_club_members_service.dart';
import 'package:speaxpoint/view_models/base_view_mode.dart';

class ProfileManagementViewModel extends BaseViewModel {
  Result<Toastmaster, Failure>? _toastmasterDetailsStatus;
  Result<Toastmaster, Failure>? get getToastmasterDetailsStatus =>
      _toastmasterDetailsStatus;

  Result<Unit, Failure>? _updateToastmasterDetailsStatus;
  Result<Unit, Failure>? get updateToastmasterDetailsStatus =>
      _updateToastmasterDetailsStatus;

  final IManageClubMembersService _manageClubMembersService;
  final IAuthenticationService _authenticationService;

  ProfileManagementViewModel(
      this._manageClubMembersService, this._authenticationService);

  Future<void> getToastmasterDetails() async {
    setLoading(true);
    _toastmasterDetailsStatus =
        await _manageClubMembersService.getToastmasterDetails(
            _authenticationService.userCredential!.user!.uid);
    setLoading(false);
  }

  Future<void> updateUserDetails({
    required String toastmasterName,
    required String gender,
    required String dataOfBirth,
    required String currentPath,
    required String currentProject,
    required int currentLevel,
    required String memberRole,
    required String toastmasterUsername,
  }) async {
    setLoading(true);
    _updateToastmasterDetailsStatus =
        await _manageClubMembersService.updateMemberDetails(
      Toastmaster.fromJson(
        {
          'toastmasterName': toastmasterName,
          'currentPath': currentPath,
          'currentProject': currentProject,
          'currentLevel': currentLevel,
          'toastmasterBirthDate': dataOfBirth,
          'gender': gender,
          'memberOfficalRole': memberRole,
          'toastmasterId': _authenticationService.userCredential!.user!.uid,
          'toastmasterUsername': toastmasterUsername,
        },
      ),
    );
    setLoading(false);
  }
}
