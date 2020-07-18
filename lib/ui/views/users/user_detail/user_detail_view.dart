import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../app/locator.dart';
import '../../../widgets/page_header.dart';
import 'user_detail_viewmodel.dart';

class UserDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserDetailViewModel>.reactive(
      viewModelBuilder: () => locator<UserDetailViewModel>(),
      initialiseSpecialViewModelsOnce: true,
      disposeViewModel: false,
      onModelReady: (model) => model.initialize(),
      builder: (context, model, child) {
        return _UserDetailViewBody(model: model);
      },
    );
  }
}

class _UserDetailViewBody extends StatelessWidget {
  final UserDetailViewModel model;

  const _UserDetailViewBody({Key key, this.model}) : super(key: key);

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
