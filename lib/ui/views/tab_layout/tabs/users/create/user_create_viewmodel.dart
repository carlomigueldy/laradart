import 'package:stacked/stacked.dart';

import '../../../../../../app/locator.dart';
import '../../../../../../services/alert_service.dart';
import '../../../../../../services/authentication_service.dart';

class UserCreateViewModel extends BaseViewModel {
  final _alertService = locator<AlertService>();
  final _authService = locator<AuthenticationService>();

  initialize() {
    print('[UserCreateViewModel] init');
  }
}
