import 'package:stacked/stacked.dart';

import '../../../app/locator.dart';
import '../../../datamodels/user.dart';
import '../../../services/authentication_service.dart';

class TabLayoutViewModel extends IndexTrackingViewModel {
  final _authService = locator<AuthenticationService>();

  User get user => _authService.user;

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  setIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }
}
