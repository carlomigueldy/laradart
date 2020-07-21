import 'package:flutter/material.dart';

import '../../tab_layout_viewmodel.dart';
import '../explore/explore_view.dart';
import '../home/home_view.dart';
import '../search/search_view.dart';
import '../settings/settings_view.dart';
import '../users/user_list_view.dart';

class MobileScreen extends StatelessWidget {
  final TabLayoutViewModel model;

  const MobileScreen({
    Key key,
    this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // only have a PageController when using PageView
    final _pageController = PageController(initialPage: 0);

    return SafeArea(
      child: Scaffold(
        // body: _pageTransitionSwitcher(model),
        body: PageView(
          onPageChanged: model.setIndex,
          controller: _pageController,
          children: [
            HomeView(),
            UserListView(),
            SearchView(),
            ExploreView(),
            SettingsView(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 32,
          type: BottomNavigationBarType.fixed,
          currentIndex: model.currentIndex,
          onTap: (int value) {
            // only when using pageTransitionSwitcher
            // model.setIndex(value);

            // jump to page when using PageView
            _pageController.jumpToPage(value);
          },
          items: model.tabs.map((item) {
            return BottomNavigationBarItem(
              icon: item['title'] != "Settings"
                  ? Icon(item['icon'])
                  : item['icon'],
              title: SizedBox.shrink(),
            );
          }).toList(),
        ),
      ),
    );
  }
}
