import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../app/locator.dart';
import '../../../datamodels/user.dart';
import '../../../services/authentication_service.dart';
import '../../../services/theme_service.dart';
import '../users/user_list_view.dart';
import 'tabs/explore/explore_view.dart';
import 'tabs/home/home_view.dart';
import 'tabs/search/search_view.dart';
import 'tabs/settings/settings_view.dart';

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
          "icon": CupertinoIcons.home,
        },
        {
          "title": "Users",
          "icon": CupertinoIcons.person,
        },
        {
          "title": "Search",
          "icon": CupertinoIcons.search,
        },
        {
          "title": "Explore",
          "icon": CupertinoIcons.location,
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

  Widget getViewForIndex(index) {
    switch (index) {
      case 0:
        return HomeView();
      case 1:
        return UserListView();
      case 2:
        return SearchView();
      case 3:
        return ExploreView();
      case 4:
        return SettingsView();
      default:
        return HomeView();
    }
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
