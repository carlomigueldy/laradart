import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

import '../../../../../app/locator.dart';
import '../../../../../ui/widgets/page_header.dart';
import '../settings/settings_viewmodel.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingsViewModel>.reactive(
      viewModelBuilder: () => locator<SettingsViewModel>(),
      disposeViewModel: false,
      initialiseSpecialViewModelsOnce: true,
      builder: (context, model, child) {
        return SafeArea(
          child: model.user != null
              ? ScreenTypeLayout(
                  mobile: _MobileScreen(model: model),
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }
}

class _MobileScreen extends StatelessWidget {
  final SettingsViewModel model;

  const _MobileScreen({
    Key key,
    this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        PageHeader(
          title: 'Settings',
          subtitle: model.user != null ? model.user.fullName : 'anonymous user',
        ),
        SizedBox(height: 5),
        Center(
          child: _UserAvatar(model: model),
        ),
        SizedBox(height: 10),
        listHeader(
          label: 'Profile',
          context: context,
        ),
        _UserProfileDetail(model: model),
        SizedBox(height: 100),
        listHeader(
          label: 'Security',
          context: context,
        ),
        listSubHeader(
          text:
              'Feeling not secured? Change your password to protect your account.',
          context: context,
        ),
        _UserSecurityDetail(),
        SizedBox(height: 100),
        listHeader(
          label: 'Account',
          context: context,
        ),
        listSubHeader(
          text: 'Lorem ipsum you can log out from here. See you again!',
          context: context,
        ),
        Container(
          height: 50,
          margin: EdgeInsets.all(15),
          width: double.infinity,
          child: OutlineButton(
            color: Theme.of(context).primaryColor,
            textColor: Theme.of(context).primaryColor,
            onPressed: () => model.logout(),
            child: Text('Sign Out'),
          ),
        ),
        SizedBox(height: 50),
      ],
    );
  }

  Padding listHeader({
    BuildContext context,
    @required String label,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 5,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget listSubHeader({String text, BuildContext context}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _UserAvatar extends StatelessWidget {
  const _UserAvatar({
    Key key,
    @required this.model,
  }) : super(key: key);

  final SettingsViewModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: model.user != null
              ? NetworkImage(model.user.avatar ?? "")
              : AssetImage('icons/icon-tile.png'),
        ),
      ),
    );
  }
}

class _UserSecurityDetail extends StatelessWidget {
  const _UserSecurityDetail({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        children: [
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'New Password',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 50,
            width: double.infinity,
            child: FlatButton(
              textColor: Theme.of(context).primaryColor,
              onPressed: () {},
              child: Text('Update Password'),
            ),
          )
        ],
      ),
    );
  }
}

class _UserProfileDetail extends StatelessWidget {
  const _UserProfileDetail({
    Key key,
    @required this.model,
  }) : super(key: key);

  final SettingsViewModel model;

  @override
  Widget build(BuildContext context) {
    return model.user != null
        ? Column(
            children: [
              ListTile(
                title: Text(model.user.firstName ?? ""),
                subtitle: Text('First Name'),
              ),
              ListTile(
                title: Text(model.user.middleName ?? ""),
                subtitle: Text('Middle Name'),
              ),
              ListTile(
                title: Text(model.user.lastName ?? ""),
                subtitle: Text('Last Name'),
              ),
              ListTile(
                title: Text(model.user.email ?? ""),
                subtitle: Text('Email'),
              )
            ],
          )
        : SizedBox.shrink();
  }
}
