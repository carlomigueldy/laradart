import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import './user_list_viewmodel.dart';
import '../../../../../app/locator.dart';
import '../../../../../datamodels/user.dart';
import '../../../../../styles/button_text_style_constants.dart';
import '../../../../../styles/color_constants.dart';
import '../../../../widgets/page_header.dart';
import '../../../../../app/routes.gr.dart';

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
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.indigo,
        label: Row(
          children: [
            Icon(
              Icons.add,
              color: getColor(type: ColorType.dark),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'New User',
              style: getButtonTextStyle(style: ButtonTextStyle.dark),
            ),
          ],
        ),
        onPressed: () => model.navigateToCreateView(),
      ),
      body: !model.isBusy
          ? ListView(
              children: [
                PageHeader(
                  title: 'Users',
                ),
                ...userList(),
              ],
            )
          : Center(child: CircularProgressIndicator()),
    );
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
