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
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: model.isBusy
                ? SafeArea(child: Center(child: CircularProgressIndicator()))
                // : Center(
                //     child: Text('timezones...'),
                //   )
                : !model.hasError
                    ? ListView.separated(
                        itemBuilder: (context, index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              title: Text(
                                model.data[index]['name'],
                              ),
                              trailing: Icon(Icons.remove_red_eye),
                              onTap: () =>
                                  model.navigateToDetail(userId: index),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 1,
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
