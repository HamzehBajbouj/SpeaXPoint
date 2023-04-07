import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/models/toastmaster.dart';
import 'package:speaxpoint/services/Failure.dart';
import 'package:speaxpoint/services/authentication/i_authentication_service.dart';
import 'package:speaxpoint/services/manage_club_members/i_manage_club_members_service.dart';
import 'package:speaxpoint/view_models/base_view_mode.dart';

class ManageMemberAccountViewModel extends BaseViewModel {
  final IManageClubMembersService _manageClubMembersService;
  final IAuthenticationService _authenticationService;

  Result<Unit, Failure>? _registrationStatus;
  Result<Unit, Failure>? get registrationStatus => _registrationStatus;

  Result<Toastmaster, Failure>? _toastmasterDetailsStatus;
  Result<Toastmaster, Failure>? get getToastmasterDetailsStatus =>
      _toastmasterDetailsStatus;

  Result<Unit, Failure>? _updateToastmasterDetailsStatus;
  Result<Unit, Failure>? get updateToastmasterDetailsStatus =>
      _updateToastmasterDetailsStatus;



  ManageMemberAccountViewModel(
      this._manageClubMembersService, this._authenticationService);

// i have to add the photo link here as well
  Future<void> registerNewClubMember({
    required String email,
    required String password,
    required String toastmasterName,
    required String memberRole,
    String? gender,
    String? dataOfBirth,
    String? currentPath,
    String? currentProject,
    int? currentLevel,
  }) async {
    setLoading(true);
    _registrationStatus = await _manageClubMembersService.registerNewMember(
      email,
      password,
      Toastmaster.fromJson(
        {
          'clubId': _authenticationService.userCredential?.user?.uid,
          'toastmasterName': toastmasterName,
          'currentPath': currentPath,
          'currentProject': currentProject,
          'currentLevel': currentLevel,
          'toastmasterBirthDate': dataOfBirth,
          'gender': gender,
          'memberOfficalRole': memberRole,
        },
      ),
    );

    setLoading(false);
  }

  Future<void> getToastmasterDetails(String toastmasterId) async {
    setLoading(true);
    _toastmasterDetailsStatus =
        await _manageClubMembersService.getToastmasterDetails(toastmasterId);
    setLoading(false);
  }

  Future<void> updateUserDetails({
    required String toastmasterName,
    required String memberRole,
    required String gender,
    required String dataOfBirth,
    required String currentPath,
    required String currentProject,
    required String toastmasterId,
    required int currentLevel,
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
          'toastmasterId': toastmasterId,
        },
      ),
    );
    setLoading(false);
  }
}
