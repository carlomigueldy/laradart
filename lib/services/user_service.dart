import 'package:observable_ish/observable_ish.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:dio/dio.dart';

import '../app/config.dart';
import '../datamodels/user.dart';
import '../app/locator.dart';
import './authentication_service.dart';
import './alert_service.dart';

@lazySingleton
class UserService with ReactiveServiceMixin {
  /// Here we instantiate all the services and
  /// other classes that this [UserService] requires.
  final _authService = locator<AuthenticationService>();
  final _alertService = locator<AlertService>();

  UserService() {
    listenToReactiveValues([_users, _user]);
  }

  /// @return [List<User>] users
  RxValue<List<User>> _users = RxValue<List<User>>(initial: []);
  List<User> get users => _users.value;

  // @return [User] user
  RxValue<User> _user = RxValue<User>(initial: null);
  User get user => _user.value;

  static String message = "";
  static const String endpoint = "/api/users";

  /// Fetch all users from API.
  ///
  /// @return [Response]
  Future fetchAll() async {
    try {
      Response response = await dio.get(
        '$endpoint',
        options: _authService.authorizationHeader(),
      );

      List<User> users = [];

      if (response.statusCode == 200) {
        for (var json in response.data['data']) {
          users.add(User.fromJson(json));
        }
      }

      _users.value = users;

      return users;
    } on DioError catch (e) {
      _authService.handleError(e);
    }
  }

  /// Fetch the current authenticated user.
  ///
  /// @return void
  Future fetch({int userId}) async {
    try {
      Response response = await dio.get(
        '$endpoint/$userId',
        options: _authService.authorizationHeader(),
      );

      User user = User.fromJson(response.data['data']);
      _user.value = user;
      return user;
    } on DioError catch (e) {
      _authService.handleError(e);
    }
  }

  /// Request create new resource in API.
  ///
  /// @param [User] user
  /// @return void
  Future requestCreate({User form}) async {
    try {
      Response response = await dio.post(
        '$endpoint',
        options: _authService.authorizationHeader(),
        data: form.toJson(),
      );

      message = response.data['message'];
      _alertService.showSnackbar(
        message: message,
        type: SnackBarType.INFO,
      );
    } on DioError catch (e) {
      _authService.handleError(e);
    }
  }

  /// Request update existing resource in API.
  ///
  /// @param [User] user
  /// @return void
  Future requestUpdate({User form, int userId}) async {
    try {
      Response response = await dio.put(
        '$endpoint/$userId',
        options: _authService.authorizationHeader(),
        data: form.toJson(),
      );

      message = response.data['message'];
      _alertService.showSnackbar(
        message: message,
        type: SnackBarType.INFO,
      );
    } on DioError catch (e) {
      _authService.handleError(e);
    }
  }

  /// Request to delete a user from API.
  ///
  /// @return void
  Future requestDelete({int userId}) async {
    try {
      Response response = await dio.delete(
        '$endpoint/$userId',
        options: _authService.authorizationHeader(),
      );

      message = response.data['message'];
      _alertService.showSnackbar(
        message: message,
        type: SnackBarType.INFO,
      );
    } on DioError catch (e) {
      _authService.handleError(e);
    }
  }
}
