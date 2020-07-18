import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/page_header.dart';
import '../../../app/locator.dart';
import 'timezones_list_viewmodel.dart';

class TimezoneListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TimezoneListViewModel>.reactive(
      viewModelBuilder: () => locator<TimezoneListViewModel>(),
      initialiseSpecialViewModelsOnce: true,
      disposeViewModel: false,
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Timezones'),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: model.isBusy
                ? SafeArea(child: Center(child: CircularProgressIndicator()))
                // : Center(
                //     child: Text('timezones...'),
                //   )
                : !model.hasError
                    ? ListView.separated(
                        itemBuilder: (context, index) => Text(
                          model.data[index]['name'],
                        ),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 20,
                        ),
                        itemCount: model.data.length,
                      )
                    : Text('Error occurred :('),
          ),
        );
      },
    );
  }
}
