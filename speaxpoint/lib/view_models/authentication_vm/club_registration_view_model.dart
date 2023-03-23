import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/services/Failure.dart';
import 'package:speaxpoint/services/authentication/i_authentication_service.dart';
import 'package:speaxpoint/view_models/base_view_mode.dart';

class ClubRegistrationViewModel extends BaseViewModel {
  final IAuthenticationService _authenticationService;
  ClubRegistrationViewModel(this._authenticationService);

  Result<Unit, Failure>? _registrationStatus;
  Result<Unit, Failure>? get registrationStatus => _registrationStatus;

  Result<Unit, Failure>? _clubUsernameRegistrationStatus;
  Result<Unit, Failure>? get clubUsernameRegistrationStatus =>
      _clubUsernameRegistrationStatus;

  set clubUsernameRegistrationStatus(
          Result<Unit, Failure>? clubUsernameRegistrationStatus) =>
      _clubUsernameRegistrationStatus = clubUsernameRegistrationStatus;

  Future<void> registerNewClub({
    required String email,
    required String password,
  }) async {
    setLoading(true);
    _registrationStatus = await _authenticationService.registerNewClub(
        email: email, password: password);
    setLoading(false);
  }

  Future<void> registerClubUsername({required String username}) async {
    setLoading(true);
    _clubUsernameRegistrationStatus =
        await _authenticationService.registerClubUserName(username: username);
    setLoading(false);
  }
}
