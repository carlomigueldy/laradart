// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:laradart/services/authentication_service.dart';
import 'package:laradart/services/third_party_services_module.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:laradart/services/theme_service.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  final thirdPartyServicesModule = _$ThirdPartyServicesModule();
  g.registerLazySingleton<AuthenticationService>(() => AuthenticationService());
  g.registerLazySingleton<DialogService>(
      () => thirdPartyServicesModule.dialogService);
  g.registerLazySingleton<NavigationService>(
      () => thirdPartyServicesModule.navigationService);
  g.registerLazySingleton<SnackbarService>(
      () => thirdPartyServicesModule.snackbarService);
  g.registerLazySingleton<ThemeService>(() => ThemeService());
}

class _$ThirdPartyServicesModule extends ThirdPartyServicesModule {
  @override
  DialogService get dialogService => DialogService();
  @override
  NavigationService get navigationService => NavigationService();
  @override
  SnackbarService get snackbarService => SnackbarService();
}
