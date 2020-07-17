import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../../app/locator.dart';
import '../../../../widgets/page_header.dart';
import './home_viewmodel.dart';

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
          height: 225,
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 15,
            itemBuilder: (context, index) {
              return Container(
                height: 225,
                width: 125,
                margin: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(15),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
