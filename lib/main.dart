import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import './app/locator.dart';
import './app/routes.gr.dart';
import './services/theme_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(LaraDartApp());
}

class LaraDartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => LaraDartViewModel(),
      builder: (context, model, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'LaraDart Starter',
        themeMode: model.themeMode,
        theme: model.themeData,
        navigatorKey: locator<NavigationService>().navigatorKey,
        onGenerateRoute: Router().onGenerateRoute,
        initialRoute: Routes.splashView,
      ),
    );
  }
}

class LaraDartViewModel extends ReactiveViewModel {
  final _themeService = locator<ThemeService>();

  ThemeMode get themeMode => _themeService.theme;
  ThemeData get themeData => _themeService.isLight
      ? _themeService.lightTheme
      : _themeService.darkTheme;

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_themeService];
}
