// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:laradart/ui/views/splash/splash_view.dart';
import 'package:laradart/ui/views/login/login_view.dart';
import 'package:laradart/ui/views/tab_layout/tab_layout_view.dart';
import 'package:laradart/ui/views/timezones/timezones_list_view.dart';
import 'package:laradart/ui/views/tab_layout/tabs/users/user_list_view.dart';
import 'package:laradart/ui/views/tab_layout/tabs/users/user_detail/user_detail_view.dart';
import 'package:laradart/ui/views/tab_layout/tabs/users/create/user_create_view.dart';

class Routes {
  static const String splashView = '/';
  static const String loginView = '/login';
  static const String tabLayoutView = '/home';
  static const String timezoneListView = '/timezones';
  static const String userListView = '/users';
  static const String _userDetailView = '/users/:id/detail';
  static userDetailView({@required id}) => '/users/$id/detail';
  static const String userCreateView = '/users/create';
  static const all = <String>{
    splashView,
    loginView,
    tabLayoutView,
    timezoneListView,
    userListView,
    _userDetailView,
    userCreateView,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashView, page: SplashView),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.tabLayoutView, page: TabLayoutView),
    RouteDef(Routes.timezoneListView, page: TimezoneListView),
    RouteDef(Routes.userListView, page: UserListView),
    RouteDef(Routes._userDetailView, page: UserDetailView),
    RouteDef(Routes.userCreateView, page: UserCreateView),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    SplashView: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SplashView(),
        settings: data,
      );
    },
    LoginView: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginView(),
        settings: data,
      );
    },
    TabLayoutView: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => TabLayoutView(),
        settings: data,
      );
    },
    TimezoneListView: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => TimezoneListView(),
        settings: data,
      );
    },
    UserListView: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => UserListView(),
        settings: data,
      );
    },
    UserDetailView: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => UserDetailView(),
        settings: data,
      );
    },
    UserCreateView: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => UserCreateView(),
        settings: data,
      );
    },
  };
}
