import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../widgets/page_header.dart';
import '../../../../../app/locator.dart';
import './search_viewmodel.dart';

class SearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchViewModel>.reactive(
      viewModelBuilder: () => locator<SearchViewModel>(),
      initialiseSpecialViewModelsOnce: true,
      disposeViewModel: false,
      onModelReady: (model) => model.initialize(),
      builder: (context, model, child) {
        return _SearchViewBody(model: model);
      },
    );
  }
}

class _SearchViewBody extends StatelessWidget {
  final SearchViewModel model;

  const _SearchViewBody({Key key, this.model}) : super(key: key);

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
