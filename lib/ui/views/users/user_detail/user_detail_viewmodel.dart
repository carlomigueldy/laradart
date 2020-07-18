import 'package:dio/dio.dart';
import 'package:stacked/stacked.dart';

import '../../../../datamodels/user.dart';
import '../../../../services/authentication_service.dart';
import '../../../../app/config.dart';
import '../../../../app/locator.dart';
import '../../../../services/alert_service.dart';

class UserDetailViewModel extends FutureViewModel<User> {
  final _alertService = locator<AlertService>();
  final _authService = locator<AuthenticationService>();

  final int userId;

  UserDetailViewModel({
    this.userId,
  });

  initialize({int userId}) {
    print('[UserDetailViewModel] init');
  }

  showSnackbar() {
    _alertService.showSnackbar(
      message: "Snackbar called!",
      type: SnackBarType.INFO,
    );
  }

  @override
  Future<User> futureToRun() async {
    print('[UserDetailViewModel] futureToRun with userId $userId');
    try {
      setBusy(true);
      Response response = await dio.get(
        '/api/users/$userId',
        options: _authService.authorizationHeader(),
      );
      setBusy(false);

      User user = User.fromJson(await response.data['data']);

      if (user.id == null) {
        setError('No user found.');
      } else {
        return user;
      }
    } on DioError catch (error) {
      print(error.response.realUri);
      _authService.handleError(error);
    }
  }
}
