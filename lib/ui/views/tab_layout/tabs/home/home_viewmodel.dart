import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laradart/datamodels/user.dart';
import 'package:laradart/services/alert_service.dart';
import 'package:laradart/services/authentication_service.dart';
import 'package:laradart/services/theme_service.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:laradart/app/locator.dart';
import 'package:laradart/app/routes.gr.dart';
import 'package:stacked/stacked.dart';

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
    print('init');
  }

  setToken() {}

  navigateToLogin() {
    _navigationService.navigateTo(Routes.loginView);
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
