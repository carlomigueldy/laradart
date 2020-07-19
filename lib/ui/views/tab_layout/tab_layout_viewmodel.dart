import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laradart/services/theme_service.dart';
import 'package:stacked/stacked.dart';

import '../../../app/locator.dart';
import '../../../datamodels/user.dart';
import '../../../services/authentication_service.dart';

class TabLayoutViewModel extends ReactiveViewModel {
  final _authService = locator<AuthenticationService>();
  final _themeService = locator<ThemeService>();

  @override
  List<ReactiveServiceMixin> get reactiveServices =>
      [_authService, _themeService];

  User get user => _authService.user;
  List<Map<String, dynamic>> get tabs => [
        {
          "title": "Dashboard",
          "icon": Icon(CupertinoIcons.home),
        },
        {
          "title": "Users",
          "icon": Icon(CupertinoIcons.person),
        },
        {
          "title": "Search",
          "icon": Icon(CupertinoIcons.search),
        },
        {
          "title": "Explore",
          "icon": Icon(CupertinoIcons.location),
        },
        {
          "title": "Settings",
          "icon": CircleAvatar(
            backgroundImage: _authService.user != null
                ? NetworkImage(_authService.user.avatar)
                : AssetImage('icons/icon-tile.png'),
          )
        },
      ];

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  setIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }

  Future logout() async {
    setBusy(true);
    await _authService.logout();
    setBusy(false);
  }

  toggleTheme() {
    _themeService.toggleTheme();
    notifyListeners();
  }
}
