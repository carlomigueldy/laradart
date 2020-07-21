import 'package:auto_route/auto_route_annotations.dart';

// Views
import '../ui/views/login/login_view.dart';
import '../ui/views/splash/splash_view.dart';
import '../ui/views/tab_layout/tab_layout_view.dart';
import '../ui/views/timezones/timezones_list_view.dart';
import '../ui/views/tab_layout/tabs/users/create/user_create_view.dart';
import '../ui/views/tab_layout/tabs/users/user_detail/user_detail_view.dart';
import '../ui/views/tab_layout/tabs/users/user_list_view.dart';

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
      page: TabLayoutView,
      // page: HomeView,
    ),
    MaterialRoute(
      path: '/timezones',
      page: TimezoneListView,
    ),
    MaterialRoute(
      path: '/users',
      page: UserListView,
    ),
    MaterialRoute(
      path: '/users/:id/detail',
      page: UserDetailView,
    ),
    MaterialRoute(
      path: '/users/create',
      page: UserCreateView,
    ),
  ],
)
class $Router {}
