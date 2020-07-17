import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

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
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.asset(
            'assets/icons/icon-tile.png',
            height: 150,
            width: 150,
          ),
          Text("Hello welcome back, " + model.userFullName),
          RaisedButton(
            child: Text('Display Snackbar'),
            onPressed: () => model.showSnackbar(),
            elevation: 0,
          ),
        ],
      ),
    );
  }
}
