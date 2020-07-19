import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/config.dart';
import '../../../datamodels/user.dart';
import '../../../app/locator.dart';
import '../../../app/routes.gr.dart';
import '../../../services/authentication_service.dart';

@singleton
class UserListViewModel extends FutureViewModel<List<User>> {
  final _authService = locator<AuthenticationService>();
  final _router = locator<NavigationService>();

  @override
  Future<List<User>> futureToRun() async {
    try {
      print('[UserListViewModel] futureToRun');
      setBusy(true);
      Response response = await dio.get(
        '/api/users',
        options: _authService.authorizationHeader(),
      );
      setBusy(false);

      List<User> users = [];

      for (var item in response.data['data']) {
        users.add(User.fromJson(item));
      }

      return users;
    } on DioError catch (error) {
      _authService.handleError(error);
    }
  }

  navigateToDetail({int userId}) {
    _router.navigateTo(Routes.userDetailView(id: userId));
  }
}
