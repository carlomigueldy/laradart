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
    return ListView(
      children: [
        Container(
          height: 300,
          color: Colors.blue,
          child: Column(
            children: [
              Text(model.loggedIn ? 'logged in' : 'not logged in'),
              RaisedButton(
                child: Text('set token'),
                onPressed: () => model.setToken(),
              ),
              FlatButton(
                child: Text('go login'),
                onPressed: () => model.navigateToLogin(),
              ),
              FlatButton(
                child: Text('snackbar'),
                onPressed: () => model.showSnackbar(),
              )
            ],
          ),
        ),
      ],
    );
  }
}
