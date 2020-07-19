import 'package:flutter/material.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LaraDart Starter',
      themeMode: locator<ThemeService>().theme,
      theme: locator<ThemeService>().isLight
          ? locator<ThemeService>().lightTheme
          : locator<ThemeService>().darkTheme,
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: Router().onGenerateRoute,
      initialRoute: Routes.splashView,
    );
  }
}
