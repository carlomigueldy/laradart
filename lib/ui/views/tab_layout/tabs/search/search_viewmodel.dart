import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

import '../../../../../app/locator.dart';
import '../../../../../datamodels/user.dart';
import '../../../../../services/alert_service.dart';
import '../../../../../services/authentication_service.dart';

@singleton
class SearchViewModel extends ReactiveViewModel {
  final _authService = locator<AuthenticationService>();
  final _alertService = locator<AlertService>();

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_authService];

  User get user => _authService.user;
  String get userFullName => _authService.user.fullName ?? 'anonymous user';

  initialize() {
    print('[SearchViewModel] init');
  }

  showSnackbar() {
    _alertService.showSnackbar(
      message: "Snackbar called!",
      type: SnackBarType.INFO,
    );
  }
}
