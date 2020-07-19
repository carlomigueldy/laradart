import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

import './login_viewmodel.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, model, child) {
        return ScreenTypeLayout(
          mobile: _MobileScreen(model: model),
          desktop: _DesktopScreen(model: model),
          tablet: _TabletScreen(model: model),
        );
      },
    );
  }
}

class _TabletScreen extends StatelessWidget {
  final LoginViewModel model;

  _TabletScreen({
    this.model,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: screenSize.height,
          width: screenSize.width,
          // child: LoginForm(model: model),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: screenSize.height,
                width: screenSize.width * 0.4,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://images.pexels.com/photos/586063/pexels-photo-586063.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: screenSize.height,
                width: screenSize.width * 0.6,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: LoginForm(
                    model: model,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DesktopScreen extends StatelessWidget {
  final LoginViewModel model;

  _DesktopScreen({
    this.model,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: screenSize.height,
          width: screenSize.width,
          // child: LoginForm(model: model),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: screenSize.height,
                width: screenSize.width * 0.6,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://images.pexels.com/photos/586063/pexels-photo-586063.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: screenSize.height,
                width: screenSize.width * 0.4,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 45),
                  child: LoginForm(
                    model: model,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MobileScreen extends StatelessWidget {
  final LoginViewModel model;

  _MobileScreen({
    this.model,
  });
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 30,
          ),
          color: Colors.white,
          child: LoginForm(model: model),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key key,
    @required this.model,
  }) : super(key: key);

  final LoginViewModel model;

  @override
  Widget build(BuildContext context) {
    final _form = GlobalKey<FormState>();
    final _email = TextEditingController(text: 'admin@admin.com');
    final _password = TextEditingController(text: 'password');
    final screenSize = MediaQuery.of(context).size;

    return Form(
      key: _form,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  'Cool App Name',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                  ),
                ),
                Text(
                  "Lorem ipsum the app name is so cool I don't event care. "
                  "I am using a stock photo don't worry.",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: screenSize.height * 0.1),
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextFormField(
                  controller: _email,
                  enabled: !model.isBusy,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextFormField(
                  controller: _password,
                  enabled: !model.isBusy,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                width: getValueForScreenType<double>(
                  context: context,
                  mobile: 250,
                  desktop: 250,
                  tablet: 225,
                ),
                height: 50,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  onPressed: () {
                    if (!model.isBusy && _form.currentState.validate()) {
                      model.login();
                    }
                  },
                  child: !model.isBusy
                      ? Text(
                          'LOGIN',
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        ),
                ),
              ),
              SizedBox(height: 30),
            ],
          )
        ],
      ),
    );
  }
}
