import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../../app/locator.dart';
import '../../../../../ui/views/tab_layout/tabs/explore/explore_viewmodel.dart';
import '../../../../../ui/widgets/page_header.dart';

class ExploreView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ExploreViewModel>.reactive(
      viewModelBuilder: () => locator<ExploreViewModel>(),
      initialiseSpecialViewModelsOnce: true,
      disposeViewModel: false,
      onModelReady: (model) => model.initialize(),
      builder: (context, model, child) {
        return _ExploreViewBody(model: model);
      },
    );
  }
}

class _ExploreViewBody extends StatelessWidget {
  final ExploreViewModel model;

  const _ExploreViewBody({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        PageHeader(
          title: 'Explore',
        ),
        Container(
          height: 500,
          margin: const EdgeInsets.symmetric(horizontal: 50),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/illustrations/png/explore.png'),
            ),
          ),
        )
      ],
    );
  }
}
