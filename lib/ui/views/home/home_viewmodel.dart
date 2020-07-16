import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laradart/services/authentication_service.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:laradart/app/locator.dart';
import 'package:laradart/app/routes.gr.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends ReactiveViewModel {
  final _authService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();
  final _snackbarService = locator<SnackbarService>();

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_authService];

  bool get loggedIn => _authService.loggedIn;

  setToken() {
    _authService.setToken('Bearer');
  }

  navigateToLogin() {
    _navigationService.navigateTo(Routes.loginView);
  }

  showSnackbar() {
    _snackbarService.showCustomSnackBar(
      message: "Hello there user!",
      borderRadius: 15,
      margin: EdgeInsets.all(15),
      shouldIconPulse: false,
      snackStyle: SnackStyle.FLOATING,
      snackPosition: SnackPosition.TOP,
      dismissDirection: SnackDismissDirection.HORIZONTAL,
      duration: const Duration(seconds: 2),
      isDismissible: true,
    );
  }
}
