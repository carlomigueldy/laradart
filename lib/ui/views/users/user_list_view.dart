import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../datamodels/user.dart';
import '../../widgets/page_header.dart';
import '../../../app/locator.dart';
import 'user_list_viewmodel.dart';

class UserListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserListViewModel>.reactive(
      viewModelBuilder: () => locator<UserListViewModel>(),
      initialiseSpecialViewModelsOnce: true,
      disposeViewModel: false,
      builder: (context, model, child) {
        return _UserListViewBody(model: model);
      },
    );
  }
}

class _UserListViewBody extends StatelessWidget {
  final UserListViewModel model;

  const _UserListViewBody({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !model.isBusy
        ? ListView(
            children: [
              PageHeader(
                title: 'Users',
              ),
              ...userList(),
            ],
          )
        : Center(child: CircularProgressIndicator());
  }

  List<ListTile> userList() {
    return model.data.map((User user) {
      return ListTile(
        title: Text(user.fullName),
        subtitle: Text(user.email),
        trailing: Icon(Icons.more_vert),
        onTap: () => model.navigateToDetail(userId: user.id),
      );
    }).toList();
  }
}
