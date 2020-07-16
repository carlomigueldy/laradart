import 'package:laradart/app/locator.dart';
import 'package:laradart/app/routes.gr.dart';
import 'package:laradart/services/authentication_service.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked/stacked.dart';

class LoginViewModel extends ReactiveViewModel {
  final _authService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_authService];

  String get token => _authService.token;

  login() {
    _authService.loginWithEmail(
      EmailCredential(
        email: "admin@admin.com",
        password: "password",
      ),
    );
  }

  deleteToken() {
    _authService.deleteToken();
  }

  navigateToHome() {
    _navigationService.back();
  }
}
