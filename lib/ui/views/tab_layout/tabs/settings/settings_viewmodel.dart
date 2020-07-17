import 'package:laradart/services/authentication_service.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:laradart/app/locator.dart';
import 'package:stacked/stacked.dart';

class SettingsViewModel extends ReactiveViewModel {
  final _authService = locator<AuthenticationService>();

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_authService];

  bool get loggedIn => _authService.loggedIn;

  void logout() {
    _authService.logout();
  }
}
