import 'package:flutter/material.dart';
import 'package:laradart/app/locator.dart';
import 'package:laradart/ui/views/tab_layout/tabs/home/home_viewmodel.dart';
import 'package:laradart/ui/widgets/page_header.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => locator<HomeViewModel>(),
      initialiseSpecialViewModelsOnce: true,
      disposeViewModel: false,
      onModelReady: (model) => model.initialize(),
      builder: (context, model, child) {
        return _HomeViewBody(model: model);
      },
    );
  }
}

class _HomeViewBody extends StatelessWidget {
  final HomeViewModel model;

  const _HomeViewBody({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        PageHeader(
          title: 'Dashboard',
        ),
        Container(
          height: 300,
          color: Colors.blue,
        )
      ],
    );
  }
}
