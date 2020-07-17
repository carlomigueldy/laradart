// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:laradart/services/alert_service.dart';
import 'package:laradart/services/authentication_service.dart';
import 'package:laradart/services/third_party_services_module.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:laradart/ui/views/tab_layout/tabs/explore/explore_viewmodel.dart';
import 'package:laradart/ui/views/tab_layout/tabs/home/home_viewmodel.dart';
import 'package:laradart/ui/views/tab_layout/tabs/search/search_viewmodel.dart';
import 'package:laradart/ui/views/tab_layout/tabs/settings/settings_viewmodel.dart';
import 'package:laradart/services/theme_service.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  final thirdPartyServicesModule = _$ThirdPartyServicesModule();
  g.registerLazySingleton<AlertService>(() => AlertService());
  g.registerLazySingleton<AuthenticationService>(() => AuthenticationService());
  g.registerLazySingleton<DialogService>(
      () => thirdPartyServicesModule.dialogService);
  g.registerLazySingleton<NavigationService>(
      () => thirdPartyServicesModule.navigationService);
  g.registerLazySingleton<SnackbarService>(
      () => thirdPartyServicesModule.snackbarService);
  g.registerLazySingleton<ThemeService>(() => ThemeService());

  //Eager singletons must be registered in the right order
  g.registerSingleton<ExploreViewModel>(ExploreViewModel());
  g.registerSingleton<HomeViewModel>(HomeViewModel());
  g.registerSingleton<SearchViewModel>(SearchViewModel());
  g.registerSingleton<SettingsViewModel>(SettingsViewModel());
}

class _$ThirdPartyServicesModule extends ThirdPartyServicesModule {
  @override
  DialogService get dialogService => DialogService();
  @override
  NavigationService get navigationService => NavigationService();
  @override
  SnackbarService get snackbarService => SnackbarService();
}
