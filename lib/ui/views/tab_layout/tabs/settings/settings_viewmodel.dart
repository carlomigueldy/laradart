import 'package:laradart/datamodels/user.dart';
import 'package:laradart/services/authentication_service.dart';
import 'package:laradart/app/locator.dart';
import 'package:stacked/stacked.dart';

class SettingsViewModel extends ReactiveViewModel {
  final _authService = locator<AuthenticationService>();

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_authService];

  bool get loggedIn => _authService.loggedIn;
  User get user => _authService.user;

  void logout() {
    _authService.logout();
  }
}
