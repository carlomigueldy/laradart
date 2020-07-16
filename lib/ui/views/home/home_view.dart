import 'package:flutter/material.dart';
import 'package:laradart/ui/views/home/home_viewmodel.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Home'),
          ),
          body: ListView(
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
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
