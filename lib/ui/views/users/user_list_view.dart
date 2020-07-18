import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

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
      onModelReady: (model) => model.initialize(),
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
    return ListView(
      children: [
        PageHeader(
          title: 'Search',
        ),
        Container(
          height: 500,
          margin: const EdgeInsets.symmetric(horizontal: 50),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/illustrations/png/search.png'),
            ),
          ),
        )
      ],
    );
  }
}
