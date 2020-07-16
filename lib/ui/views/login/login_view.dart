import 'package:flutter/material.dart';
import 'package:laradart/ui/views/login/login_viewmodel.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Login'),
          ),
          body: ListView(
            children: [
              Container(
                height: 300,
                color: Colors.blue,
                child: Column(
                  children: [
                    Text(model.loggedIn ? 'logged in' : 'not authenticated'),
                    RaisedButton(
                      child: Text('delete token'),
                      onPressed: () => model.deleteToken(),
                    ),
                    RaisedButton(
                      onPressed: () => model.login(),
                      child: Text('Login!'),
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
