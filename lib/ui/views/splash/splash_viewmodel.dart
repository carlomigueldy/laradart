import 'package:laradart/app/locator.dart';
import 'package:laradart/services/authentication_service.dart';
import 'package:stacked/stacked.dart';

class SplashViewModel extends ReactiveViewModel {
  final _authService = locator<AuthenticationService>();

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_authService];

  init() {
    _authService.initialize();
    print('has token ' + _authService.loggedIn.toString());
  }
}
