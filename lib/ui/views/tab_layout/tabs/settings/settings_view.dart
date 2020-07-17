import 'package:flutter/material.dart';
import 'package:laradart/ui/views/tab_layout/tabs/settings/settings_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingsViewModel>.reactive(
      viewModelBuilder: () => SettingsViewModel(),
      builder: (context, model, child) {
        return SafeArea(
          child: Container(
            child: Center(
              child: FlatButton(
                child: Text('Logout'),
                onPressed: () => model.logout(),
              ),
            ),
          ),
        );
      },
    );
  }
}
