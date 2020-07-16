import 'package:injectable/injectable.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';

@lazySingleton
class AuthenticationService with ReactiveServiceMixin {
  RxValue<bool> _loggedIn = RxValue<bool>(initial: false);
  bool get loggedIn => _loggedIn.value;
  RxValue<String> _token = RxValue<String>(initial: "");
  String get token => _token.value;

  AuthenticationService() {
    listenToReactiveValues([_loggedIn, _token]);
  }

  setToken(String token) {
    _token.value = token;
  }

  deleteToken() {
    _token.value = "";
  }
}
