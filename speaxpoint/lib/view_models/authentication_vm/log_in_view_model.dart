import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/services/authentication/i_authentication_service.dart';
import 'package:speaxpoint/services/Failure.dart';
import 'package:speaxpoint/view_models/base_view_mode.dart';

class LogInViewModel extends BaseViewModel {
  final IAuthenticationService _authenticationService;
  LogInViewModel(this._authenticationService);

  Result<Unit, Failure>? _logInStatus;
  Result<Unit, Failure>? get logInStatus => _logInStatus;
  setlogInStatus(Result<Unit, Failure>? logInStatus) =>
      _logInStatus = logInStatus;

  Future<void> logIn(
      {required String email,
      required String password,
      required String userRole}) async {
    setLoading(true);
    _logInStatus =
        await _authenticationService.signIn(email: email, password: password, userRole: userRole);
    setLoading(false);
  }
}
