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

class Routes {
  static const String splashView = '/';
  static const String loginView = '/login';
  static const String tabLayoutView = '/home';
  static const all = <String>{
    splashView,
    loginView,
    tabLayoutView,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashView, page: SplashView),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.tabLayoutView, page: TabLayoutView),
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
  };
}
