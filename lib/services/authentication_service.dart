import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:laradart/datamodels/auth_response.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/config.dart';
import '../datamodels/user.dart';
import '../app/routes.gr.dart';
import '../app/locator.dart';

@lazySingleton
class AuthenticationService with ReactiveServiceMixin {
  /// Here are all the reactive values inside the service
  RxValue<String> _token = RxValue<String>(initial: "");
  String get token => _token.value;
  bool get loggedIn => _token.value.isNotEmpty ? true : false;
  RxValue<User> _user = RxValue<User>(initial: User());
  User get user => _user.value;

  /// Here we instantiate all the services and
  /// other classes that this [AuthenticationService] requires.
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final _navigationService = locator<NavigationService>();
  final _snackbarService = locator<SnackbarService>();

  AuthenticationService() {
    listenToReactiveValues([_token]);
  }

  /// Initialize the authentication service to check if user contains token.
  /// And if user contains token from [SharedPreferences] then we set [_token]
  /// to the token that was stored locally.
  ///
  /// @return void
  void initialize() async {
    final SharedPreferences prefs = await _prefs;

    if (prefs.containsKey('auth.token')) {
      String token = prefs.getString('auth.token');
      _token.value = token;
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
      // _token.value = data.accessToken;
      print(data.accessToken);

      _snackbarService.showSnackbar(message: "You have logged in!");
      _navigationService.navigateTo(Routes.homeView);

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
    try {} on DioError catch (e) {
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
    prefs.setString('auth.token', token);
  }

  /// Destroy the auth token from state and in [SharedPreferences]
  ///
  /// @return void
  void deleteToken() async {
    final SharedPreferences prefs = await _prefs;
    _token.value = "";
    prefs.remove('auth.token');
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
        _snackbarService.showSnackbar(
            message:
                "You do not have the right privileges to access this resource.");
        _navigationService.pushNamedAndRemoveUntil(Routes.loginView);
        break;
      case 422:
        _snackbarService.showSnackbar(
            message:
                "Your credentials are wrong. Please try again using the correct credentials.");
        break;
      case 401:
        _snackbarService.showSnackbar(message: "You are not logged in.");
        _navigationService.pushNamedAndRemoveUntil(Routes.loginView);
        break;
      case 404:
        _snackbarService.showSnackbar(message: "Request not found.");
        break;
      case 500:
        _snackbarService.showSnackbar(
            message:
                "There is something wrong with our servers, please report to the admin so it gets fixed.");
        break;
      default:
        _snackbarService.showSnackbar(
            message: "An error has occurred anonymously.");
    }
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
