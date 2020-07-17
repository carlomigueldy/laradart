import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

import '../../../../../datamodels/user.dart';
import '../../../../../services/authentication_service.dart';
import '../../../../../app/locator.dart';

@singleton
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
