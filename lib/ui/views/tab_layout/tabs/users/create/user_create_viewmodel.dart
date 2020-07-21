import 'package:stacked/stacked.dart';

import '../../../../../../app/locator.dart';
import '../../../../../../datamodels/user.dart';
import '../../../../../../services/user_service.dart';

class UserCreateViewModel extends BaseViewModel {
  final _userService = locator<UserService>();

  initialize() {
    print('[UserCreateViewModel] init');
  }

  void requestCreate({User form}) {
    print(form.toJson());
    _userService.requestCreate(form: form);
  }
}
