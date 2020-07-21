import 'package:flutter/material.dart';
import 'package:laradart/services/authentication_service.dart';
import 'package:laradart/styles/button_text_style_constants.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

import './login_viewmodel.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, model, child) {
        return ScreenTypeLayout(
          mobile: _MobileScreen(model: model, formKey: _formKey),
          desktop: _DesktopScreen(model: model, formKey: _formKey),
          tablet: _TabletScreen(model: model, formKey: _formKey),
        );
      },
    );
  }
}

class _TabletScreen extends StatelessWidget {
  final LoginViewModel model;
  final GlobalKey<FormState> formKey;

  _TabletScreen({
    this.model,
    this.formKey,
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
                    formKey: formKey,
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
  final GlobalKey<FormState> formKey;

  _DesktopScreen({
    this.model,
    this.formKey,
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
                    formKey: formKey,
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
  final GlobalKey<FormState> formKey;

  _MobileScreen({
    this.model,
    this.formKey,
  });
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: screenSize.height,
            padding: EdgeInsets.symmetric(
              horizontal: 30,
            ),
            color: Colors.white,
            child: LoginForm(
              model: model,
              formKey: formKey,
            ),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  LoginForm({
    Key key,
    GlobalKey<FormState> this.formKey,
    @required this.model,
  }) : super(key: key);

  final LoginViewModel model;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    // final _email = TextEditingController(text: 'admin@admin.com');
    // final _password = TextEditingController(text: 'password');
    final screenSize = MediaQuery.of(context).size;
    final Map<String, dynamic> _form = {
      "email": TextEditingController(text: 'admin@admin.com'),
      "password": TextEditingController(text: 'password'),
    };

    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                getValueForScreenType<bool>(context: context, mobile: false)
                    ? Image.asset(
                        'assets/icons/icon-tile.png',
                        fit: BoxFit.contain,
                        height: 100,
                        width: 100,
                      )
                    : SizedBox.shrink(),
                Text(
                  'Cool App Name',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: getValueForScreenType<double>(
                      context: context,
                      desktop: 36,
                      tablet: 36,
                      mobile: 24,
                    ),
                  ),
                ),
                Text(
                  "Lorem ipsum the app name is so cool I don't event care. "
                  "I am using a stock photo don't worry.",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: getValueForScreenType<double>(
                      context: context,
                      desktop: 12,
                      tablet: 12,
                      mobile: 10,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: screenSize.height * 0.1),
          Column(
            children: [
              TextFormField(
                controller: _form['email'],
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) =>
                    value.isEmpty ? 'Please provide your email address.' : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _form['password'],
                obscureText: true,
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                validator: (value) =>
                    value.isEmpty ? 'Please provide your password.' : null,
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
                    if (!model.isBusy && formKey.currentState.validate()) {
                      model.login(
                        credentials: EmailCredential(
                          email: _form['email'].text,
                          password: _form['password'].text,
                        ),
                      );
                    }
                  },
                  child: !model.isBusy
                      ? Text(
                          'LOGIN',
                          style:
                              getButtonTextStyle(style: ButtonTextStyle.dark),
                        )
                      : Center(
                          child: Container(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(),
                          ),
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
