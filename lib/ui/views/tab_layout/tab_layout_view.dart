import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laradart/ui/views/tab_layout/tab_layout_viewmodel.dart';
import 'package:laradart/ui/views/tab_layout/tabs/explore/explore_view.dart';
import 'package:laradart/ui/views/tab_layout/tabs/home/home_view.dart';
import 'package:laradart/ui/views/tab_layout/tabs/search/search_view.dart';
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
              body: PageTransitionSwitcher(
                duration: const Duration(milliseconds: 300),
                reverse: model.reverse,
                transitionBuilder: (
                  Widget child,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                ) {
                  return SharedAxisTransition(
                    child: child,
                    animation: animation,
                    secondaryAnimation: secondaryAnimation,
                    transitionType: SharedAxisTransitionType.horizontal,
                  );
                },
                child: getViewForIndex(model.currentIndex),
              ),
              bottomNavigationBar: BottomNavigationBar(
                iconSize: 32,
                type: BottomNavigationBarType.fixed,
                currentIndex: model.currentIndex,
                onTap: (int value) {
                  model.setIndex(value);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.home),
                    title: SizedBox.shrink(),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.search),
                    title: SizedBox.shrink(),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.location),
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
        return SearchView();
      case 2:
        return ExploreView();
      case 3:
        return SettingsView();
      default:
        return HomeView();
    }
  }
}
