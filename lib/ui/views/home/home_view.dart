import 'package:flutter/material.dart';
import 'package:laradart/ui/views/home/home_viewmodel.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) => model.initialize(),
      builder: (context, model, child) {
        return ScreenTypeLayout(
          mobile: Scaffold(
            appBar: AppBar(
              title: Text('Home'),
            ),
            body: _HomeViewBody(model: model),
          ),
        );
      },
    );
  }
}

class _HomeViewBody extends StatelessWidget {
  final HomeViewModel model;

  const _HomeViewBody({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(model.loggedIn ? 'You are logged in' : 'You are not logged in'),
          Text(model.isDark ? 'Theme is dark' : 'Theme is light'),
          RaisedButton(
            child: Text('Set Token'),
            onPressed: () => model.setToken(),
          ),
          RaisedButton(
            child: Text('Navigate to Login View'),
            onPressed: () => model.navigateToLogin(),
          ),
          RaisedButton(
            child: Text('Display Snackbar'),
            onPressed: () => model.showSnackbar(),
          ),
          RaisedButton(
            child: Text('Toggle Theme'),
            onPressed: () => model.toggleTheme(),
          ),
        ],
      ),
    );
  }
}
