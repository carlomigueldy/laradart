import 'package:flutter/material.dart';
import 'package:laradart/ui/views/tab_layout/tab_layout_viewmodel.dart';
import 'package:laradart/ui/views/tab_layout/tabs/home/home_view.dart';
import 'package:laradart/ui/views/tab_layout/tabs/settings/settings_view.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

class TabLayoutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TabLayoutViewModel>.reactive(
      viewModelBuilder: () => TabLayoutViewModel(),
      builder: (context, model, child) {
        return ScreenTypeLayout(
          mobile: SafeArea(
            child: Scaffold(
              body: getViewForIndex(model.currentIndex),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: model.currentIndex,
                onTap: (int value) {
                  model.setIndex(value);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    title: SizedBox.shrink(),
                  ),
                  BottomNavigationBarItem(
                    icon: CircleAvatar(
                      backgroundImage: model.user != null
                          ? NetworkImage(model.user.avatar)
                          : AssetImage('icons/icon-tile.png'),
                    ),
                    title: SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget getViewForIndex(index) {
    switch (index) {
      case 0:
        return HomeView();
      case 1:
        return SettingsView();
      default:
        return HomeView();
    }
  }
}
