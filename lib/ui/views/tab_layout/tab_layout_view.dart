import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

import './tab_layout_viewmodel.dart';
import './tabs/explore/explore_view.dart';
import './tabs/home/home_view.dart';
import './tabs/search/search_view.dart';
import './tabs/settings/settings_view.dart';

class TabLayoutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TabLayoutViewModel>.reactive(
      viewModelBuilder: () => TabLayoutViewModel(),
      builder: (context, model, child) {
        return ScreenTypeLayout(
          mobile: _MobileScreen(model: model),
          desktop: _DesktopScreen(model: model),
          tablet: _TabletScreen(model: model),
        );
      },
    );
  }
}

class _TabletScreen extends StatelessWidget {
  final TabLayoutViewModel model;

  _TabletScreen({this.model});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(),
    );
  }
}

class _DesktopScreen extends StatelessWidget {
  final TabLayoutViewModel model;

  _DesktopScreen({
    this.model,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.indigo,
          child: Icon(
            Icons.home,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        body: Container(
          height: screenSize.height,
          child: Row(
            children: [
              Container(
                height: screenSize.height,
                width: 275,
                color: Colors.grey[100],
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                child: ListView.builder(
                  itemCount: model.tabs.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(model.tabs[index]['title']),
                    onTap: () => model.setIndex(index),
                    // trailing: model.tabs[index]['icon'],
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  height: screenSize.height,
                  width: screenSize.width,
                  color: Colors.white,
                  child: getViewForIndex(model.currentIndex),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MobileScreen extends StatelessWidget {
  final TabLayoutViewModel model;

  const _MobileScreen({
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
              icon: item['icon'],
              title: SizedBox.shrink(),
            );
          }).toList(),
        ),
      ),
    );
  }

  PageTransitionSwitcher _pageTransitionSwitcher(TabLayoutViewModel model) {
    return PageTransitionSwitcher(
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
    );
  }
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
