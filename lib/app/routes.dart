import 'package:auto_route/auto_route_annotations.dart';
import 'package:laradart/ui/views/home/home_view.dart';
import 'package:laradart/ui/views/login/login_view.dart';
import 'package:laradart/ui/views/splash/splash_view.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(
      path: '/',
      page: SplashView,
      initial: true,
    ),
    MaterialRoute(
      path: '/login',
      page: LoginView,
    ),
    MaterialRoute(
      path: '/home',
      page: HomeView,
    ),
  ],
)
class $Router {}
