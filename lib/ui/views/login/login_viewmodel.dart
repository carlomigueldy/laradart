import 'package:stacked_services/stacked_services.dart';
import 'package:stacked/stacked.dart';

import '../../../app/locator.dart';
import '../../../services/authentication_service.dart';

class LoginViewModel extends ReactiveViewModel {
  final _authService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_authService];

  String get token => _authService.token;
  bool get loggedIn => _authService.loggedIn;

  Future login({EmailCredential credentials}) async {
    try {
      setBusy(true);

      await _authService.loginWithEmail(
        EmailCredential(
          email: credentials.email,
          password: credentials.password,
        ),
      );

      setBusy(false);
    } catch (e) {
      setBusy(false);
    }
  }

  deleteToken() {
    _authService.deleteToken();
  }

  navigateToHome() {
    _navigationService.back();
  }
}
