import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'user_detail_viewmodel.dart';

class UserDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RouteData routeData = RouteData.of(context);

    return ViewModelBuilder<UserDetailViewModel>.reactive(
      viewModelBuilder: () => UserDetailViewModel(
        userId: routeData.pathParams['id'].intValue,
      ),
      onModelReady: (model) => model.initialize(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('User Detail'),
          ),
          body: Center(
            child: model.isBusy
                ? CircularProgressIndicator()
                : Text(
                    model.data != null ? model.data.fullName : 'No user found',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
