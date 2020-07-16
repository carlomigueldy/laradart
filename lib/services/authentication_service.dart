import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laradart/ui/views/home/home_view.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:dio/dio.dart';

import '../app/config.dart';
import '../datamodels/auth_response.dart';
import '../datamodels/user.dart';
import '../app/routes.gr.dart';
import '../app/locator.dart';

@lazySingleton
class AuthenticationService with ReactiveServiceMixin {
  /// Here we instantiate all the services and
  /// other classes that this [AuthenticationService] requires.
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final _navigationService = locator<NavigationService>();
  final _snackbarService = locator<SnackbarService>();

  AuthenticationService() {
    listenToReactiveValues([_token]);
  }

  /// @return [String] token
  RxValue<String> _token = RxValue<String>(initial: "");
  String get token => _token.value;
  bool get loggedIn => _token.value.isNotEmpty ? true : false;

  /// @return [User] user
  RxValue<User> _user = RxValue<User>(initial: User());
  User get user => _user.value;

  static const _authTokenName = 'auth.token';

  /// Initialize the authentication service to check if user contains token.
  /// And if user contains token from [SharedPreferences] then we set [_token]
  /// to the token that was stored locally.
  ///
  /// @return void
  void initialize() async {
    final SharedPreferences prefs = await _prefs;

    if (prefs.containsKey(_authTokenName)) {
      String token = prefs.getString(_authTokenName);
      _token.value = token;

      token.isNotEmpty
          ? _navigationService.pushNamedAndRemoveUntil(Routes.homeView)
          : _navigationService.pushNamedAndRemoveUntil(Routes.loginView);
    } else {
      _navigationService.pushNamedAndRemoveUntil(Routes.loginView);
    }
  }

  /// Login with email and password.
  ///
  /// @param [EmailCredential] credentials A map containing email and password
  /// @return void
  Future loginWithEmail(EmailCredential credentials) async {
    try {
      Response response = await dio.post(
        '/api/auth/login',
        data: {
          "email": credentials.email,
          "password": credentials.password,
        },
      );

      AuthenticationResponse data =
          AuthenticationResponse.fromJson(response.data);
      _token.value = data.accessToken;
      setToken(data.accessToken);
      showSuccessSnackbar(
        message: "You have logged in",
        icon: Icons.check_circle_outline,
      );
      _navigationService.pushNamedAndRemoveUntil(Routes.homeView);

      return response;
    } on DioError catch (e) {
      handleError(e);
    }
  }

  /// Login with email and password.
  ///
  /// @param [UsernameCredential] credentials A map containing email and password
  /// @return void
  Future loginWithUsername(UsernameCredential credentials) async {
    try {
      Response response = await dio.post(
        '/api/auth/login',
        data: {
          "username": credentials.username,
          "password": credentials.password,
        },
      );

      AuthenticationResponse data =
          AuthenticationResponse.fromJson(response.data);
      _token.value = data.accessToken;
      setToken(data.accessToken);
      showSuccessSnackbar(
        message: "You have logged in",
        icon: Icons.check_circle_outline,
      );
      _navigationService.pushNamedAndRemoveUntil(Routes.homeView);

      return response;
    } on DioError catch (e) {
      handleError(e);
    }
  }

  /// Sets the authentication token in the state and also locally
  /// using [SharedPreferences]
  ///
  /// @param string [token]
  /// @return void
  void setToken(String token) async {
    final SharedPreferences prefs = await _prefs;
    _token.value = token;
    prefs.setString(_authTokenName, token);
  }

  /// Destroy the auth token from state and in [SharedPreferences]
  ///
  /// @return void
  void deleteToken() async {
    final SharedPreferences prefs = await _prefs;
    _token.value = "";
    prefs.remove(_authTokenName);
  }

  /// A callback function receiving [DioError] as first parameter
  /// then handles the error based on status code given from response.
  ///
  /// @return void
  void handleError(DioError error) {
    print(
        '[Auth Service Error] ${error.response.statusCode} ${error.response.statusMessage}');

    switch (error.response.statusCode) {
      case 403:
        showErrorSnackbar(
          icon: Icons.error_outline,
          message:
              "You do not have the right privileges to access this resource.",
        );
        _navigationService.pushNamedAndRemoveUntil(Routes.loginView);
        break;
      case 422:
        showErrorSnackbar(
          icon: Icons.error_outline,
          message:
              "Your credentials are wrong. Please try again using the correct credentials.",
        );
        break;
      case 401:
        showErrorSnackbar(
          icon: Icons.error_outline,
          message: "Incorrect credentials.",
        );
        _navigationService.pushNamedAndRemoveUntil(Routes.loginView);
        break;
      case 404:
        showErrorSnackbar(
          icon: Icons.error_outline,
          message: "Request not found.",
        );
        break;
      case 500:
        showErrorSnackbar(
          icon: Icons.error_outline,
          message:
              "There is something wrong with our servers, please report to the admin so it gets fixed.",
        );
        break;
      default:
        showErrorSnackbar(
          icon: Icons.error_outline,
          message: "An error has occurred anonymously.",
        );
    }
  }

  /// Show error [Snackbar]
  ///
  /// @param [String] message
  /// @param [IconData] icon
  /// @return void
  void showErrorSnackbar({@required String message, IconData icon}) {
    _snackbarService.showCustomSnackBar(
      message: message,
      borderRadius: 15,
      icon: Icon(
        icon,
        color: Colors.red,
      ),
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      shouldIconPulse: false,
      snackStyle: SnackStyle.FLOATING,
      snackPosition: SnackPosition.BOTTOM,
      dismissDirection: SnackDismissDirection.HORIZONTAL,
      duration: const Duration(seconds: 2),
      isDismissible: true,
    );
  }

  /// Show error [Snackbar]
  ///
  /// @param [String] message
  /// @param [IconData] icon
  /// @return void
  void showSuccessSnackbar({@required String message, IconData icon}) {
    _snackbarService.showCustomSnackBar(
      message: message,
      borderRadius: 15,
      icon: Icon(
        icon,
        color: Colors.green,
      ),
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      shouldIconPulse: false,
      snackStyle: SnackStyle.FLOATING,
      snackPosition: SnackPosition.BOTTOM,
      dismissDirection: SnackDismissDirection.HORIZONTAL,
      duration: const Duration(seconds: 2),
      isDismissible: true,
    );
  }
}

class EmailCredential {
  final String email;
  final String password;

  EmailCredential({this.email, this.password});
}

class UsernameCredential {
  final String username;
  final String password;

  UsernameCredential({this.username, this.password});
}
