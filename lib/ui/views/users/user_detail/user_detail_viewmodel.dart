import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

import '../../../../app/locator.dart';
import '../../../../services/alert_service.dart';
import '../../../../services/authentication_service.dart';

@singleton
class UserDetailViewModel extends ReactiveViewModel {
  final _authService = locator<AuthenticationService>();
  final _alertService = locator<AlertService>();

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_authService];

  initialize() {
    print('[UserDetailViewModel] init');
  }

  showSnackbar() {
    _alertService.showSnackbar(
      message: "Snackbar called!",
      type: SnackBarType.INFO,
    );
  }
}
