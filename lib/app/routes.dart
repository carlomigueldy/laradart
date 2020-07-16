import 'package:auto_route/auto_route_annotations.dart';
import 'package:laradart/ui/views/home/home_view.dart';
import 'package:laradart/ui/views/login/login_view.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    // initial route is named "/"
    MaterialRoute(path: '/', page: HomeView, initial: true),
    MaterialRoute(path: '/login', page: LoginView),
  ],
)
class $Router {}
