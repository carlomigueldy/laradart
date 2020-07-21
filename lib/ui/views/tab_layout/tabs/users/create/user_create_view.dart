import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

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
            title: Text('Create User'),
          ),
          body: SafeArea(
            child: ListView(
              children: [],
            ),
          ),
        );
      },
    );
  }
}
