import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

import '../../../app/locator.dart';
import '../../../services/authentication_service.dart';
import '../../../app/config.dart';

@singleton
class TimezoneListViewModel extends FutureViewModel<dynamic> {
  final _authService = locator<AuthenticationService>();

  @override
  Future<dynamic> futureToRun() async {
    try {
      print('[TimezoneListViewModel] futureToRun');
      setBusy(true);
      Response response = await dio.get('/api/timezones');
      setBusy(false);

      print(response.data[0]['name']);

      return await response.data;
    } on DioError catch (error) {
      _authService.handleError(error);
    }
  }
}
