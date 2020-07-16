import 'package:flutter/material.dart';
import 'package:laradart/app/locator.dart';
import 'package:laradart/app/routes.gr.dart';
import 'package:laradart/ui/views/home/home_view.dart';
import 'package:stacked_services/stacked_services.dart';

void main() {
  setupLocator();
  runApp(LaraDartApp());
}

class LaraDartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LaraDart Starter',
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: Router().onGenerateRoute,
      home: HomeView(),
    );
  }
}
