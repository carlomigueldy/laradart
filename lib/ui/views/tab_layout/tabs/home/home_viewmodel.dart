import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked/stacked.dart';

import '../../../../../app/locator.dart';
import '../../../../../app/routes.gr.dart';
import '../../../../../datamodels/user.dart';
import '../../../../../services/alert_service.dart';
import '../../../../../services/authentication_service.dart';
import '../../../../../services/theme_service.dart';

@singleton
class HomeViewModel extends ReactiveViewModel {
  final _authService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();
  final _alertService = locator<AlertService>();
  final _themeService = locator<ThemeService>();

  @override
  List<ReactiveServiceMixin> get reactiveServices => [
        _authService,
        _themeService,
      ];

  bool get loggedIn => _authService.loggedIn;
  bool get isDark => _themeService.isDark;

  int _bottomNavIndex = 0;
  int get bottomNavIndex => _bottomNavIndex;

  User get user => _authService.user;
  String get userFullName => _authService.user.fullName ?? 'anonymous user';

  initialize() {
    print('[HomeViewModel] init');
  }

  setToken() {}

  navigateToLogin() {
    _navigationService.navigateTo(Routes.loginView);
  }

  navigateToTimezoneList() {
    _navigationService.navigateTo(Routes.timezoneListView);
  }

  showSnackbar() {
    _alertService.showSnackbar(
      message: "Snackbar called!",
      type: SnackBarType.INFO,
    );
  }

  toggleTheme() {
    _themeService.toggleTheme();
  }
}
