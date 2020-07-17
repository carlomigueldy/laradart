import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

import '../../../../../app/locator.dart';
import '../../../../../services/authentication_service.dart';

@singleton
class ExploreViewModel extends ReactiveViewModel {
  final _authService = locator<AuthenticationService>();

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_authService];

  initialize() {
    print('[ExploreViewModel] init');
  }
}
