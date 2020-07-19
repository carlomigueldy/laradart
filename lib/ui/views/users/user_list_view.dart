import 'package:flutter/cupertino.dart';
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
          title: 'Users',
        ),
        Card(
          margin: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: DataTable(
              sortAscending: true,
              showCheckboxColumn: true,
              sortColumnIndex: 0,
              onSelectAll: (value) {
                print(value);
              },
              columns: const [
                DataColumn(
                    label: Text('Name'), tooltip: 'The name of the user'),
                DataColumn(label: Text('Email')),
                DataColumn(label: Text('Role')),
                DataColumn(label: Text('Actions')),
              ],
              rows: [
                DataRow(
                  onSelectChanged: (value) => print(value),
                  cells: [
                    DataCell(Text('Carlo Miguel Dy')),
                    DataCell(Text('carlomigueldy@gmail.com')),
                    DataCell(Text('super-admin')),
                    DataCell(
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {},
                            splashRadius: 20,
                          )
                        ],
                      ),
                      placeholder: true,
                    ),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text('Carlo Miguel Dy')),
                    DataCell(Text('carlomigueldy@gmail.com')),
                    DataCell(Text('super-admin')),
                    DataCell(
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {},
                            splashRadius: 20,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text('Carlo Miguel Dy')),
                    DataCell(Text('carlomigueldy@gmail.com')),
                    DataCell(Text('super-admin')),
                    DataCell(
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(CupertinoIcons.eye_solid),
                            onPressed: () {},
                            splashRadius: 20,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
