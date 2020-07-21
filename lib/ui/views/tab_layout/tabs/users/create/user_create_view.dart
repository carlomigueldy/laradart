import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../../../datamodels/user.dart';
import '../../../../../../styles/button_text_style_constants.dart';
import 'user_create_viewmodel.dart';

class UserCreateView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return ViewModelBuilder<UserCreateViewModel>.reactive(
      viewModelBuilder: () => UserCreateViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Create User'),
          ),
          body: SafeArea(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: UserCreateForm(
                    formKey: _formKey,
                    model: model,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class UserCreateForm extends StatelessWidget {
  const UserCreateForm({
    Key key,
    this.model,
    @required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final UserCreateViewModel model;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> _form = {
      "first_name": TextEditingController(text: 'Eloni'),
      "middle_name": TextEditingController(),
      "last_name": TextEditingController(text: 'Muskie'),
      "username": TextEditingController(text: 'eloniatix123'),
      "email": TextEditingController(text: 'elon@mskie.com'),
      "phone_number": TextEditingController(text: '+631124777'),
      "password": TextEditingController(text: 'password'),
      "password_confirmation": TextEditingController(text: 'password'),
      "time_zone": "America/New_York",
      "role": "user",
    };

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text('Personal Information'),
            TextFormField(
              autocorrect: false,
              controller: _form['first_name'],
              decoration: InputDecoration(
                labelText: 'First Name',
                helperText: 'Required',
              ),
              validator: (value) =>
                  value.isEmpty ? 'This field is required.' : null,
            ),
            TextFormField(
              autocorrect: false,
              controller: _form['middle_name'],
              decoration: InputDecoration(labelText: 'Middle Name'),
            ),
            TextFormField(
              autocorrect: false,
              controller: _form['last_name'],
              decoration: InputDecoration(
                labelText: 'Last Name',
                helperText: 'Required',
              ),
              validator: (value) =>
                  value.isEmpty ? 'This field is required.' : null,
            ),
            SizedBox(height: 50),
            Text('Contact Information'),
            TextFormField(
              autocorrect: false,
              controller: _form['email'],
              decoration: InputDecoration(
                labelText: 'Email',
                helperText: 'Required',
              ),
              validator: (value) =>
                  value.isEmpty ? 'This field is required.' : null,
            ),
            TextFormField(
              autocorrect: false,
              controller: _form['phone_number'],
              decoration: InputDecoration(
                labelText: 'Phone Number',
                helperText: 'Required',
              ),
              validator: (value) =>
                  value.isEmpty ? 'This field is required.' : null,
            ),
            SizedBox(height: 50),
            Text('Account Information'),
            TextFormField(
              autocorrect: false,
              controller: _form['username'],
              decoration: InputDecoration(
                labelText: 'Username',
                helperText: 'Required',
              ),
              validator: (value) =>
                  value.isEmpty ? 'This field is required.' : null,
            ),
            DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: 'Time Zone',
                helperText: 'Required',
              ),
              onChanged: (value) => _form['time_zone'] = value,
              value: _form['time_zone'].isEmpty ? null : _form['time_zone'],
              items: [
                DropdownMenuItem(
                  child: Text('America, New York'),
                  value: 'America/New_York',
                )
              ],
              isExpanded: true,
            ),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              controller: _form['password'],
              decoration: InputDecoration(
                labelText: 'Password',
                helperText: 'Required',
              ),
              validator: (value) =>
                  value.isEmpty ? 'This field is required.' : null,
            ),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              controller: _form['password_confirmation'],
              decoration: InputDecoration(
                labelText: 'Password Confirmation',
                helperText: 'Required',
              ),
              validator: (value) =>
                  value.isEmpty ? 'This field is required.' : null,
            ),
            SizedBox(height: 100),
            Container(
              height: 50,
              width: double.infinity,
              child: RaisedButton(
                child: Text(
                  'Submit',
                  style: getButtonTextStyle(style: ButtonTextStyle.dark),
                ),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    model.requestCreate(
                      form: User(
                        firstName: _form['first_name'].text,
                        middleName: _form['middle_name'].text,
                        lastName: _form['last_name'].text,
                        username: _form['username'].text,
                        email: _form['email'].text,
                        phoneNumber: _form['phone_number'].text,
                        password: _form['password'].text,
                        passwordConfirmation:
                            _form['password_confirmation'].text,
                        timeZone: _form['time_zone'],
                        role: _form['role'],
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
