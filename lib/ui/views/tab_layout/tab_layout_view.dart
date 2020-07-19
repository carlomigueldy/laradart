import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laradart/styles/button_text_style_constants.dart';
import 'package:laradart/styles/color_constants.dart';
import 'package:laradart/ui/views/users/user_list_view.dart';
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
          // tablet: _TabletScreen(model: model),
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
                child: Stack(
                  // alignment: Alignment.bottomCenter,
                  children: [
                    _sidebarItems(context: context),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        child: !model.isBusy
                            ? FlatButton(
                                splashColor: getColor(type: ColorType.accent),
                                child: Text(
                                  'Sign Out',
                                  style: getButtonTextStyle(
                                    style: ButtonTextStyle.primary,
                                  ),
                                ),
                                onPressed: () => model.logout(),
                              )
                            : Center(
                                child: Container(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator()),
                              ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        icon: Icon(
                          Icons.brightness_high,
                          color: getColor(type: ColorType.primary),
                        ),
                        onPressed: () {
                          print('TOGGLED!');
                          model.toggleTheme();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Container(
                  height: screenSize.height,
                  width: screenSize.width,
                  color: Colors.white,
                  child: _pageTransitionSwitcher(model: model),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListView _sidebarItems({BuildContext context}) {
    return ListView(children: [
      Center(
        child: Container(
          height: 150,
          width: 150,
          margin: EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: model.user != null
                  ? NetworkImage(model.user.avatar ?? "")
                  : AssetImage('icons/icon-tile.png'),
            ),
          ),
        ),
      ),
      ...model.tabs
          .asMap()
          .map(
            (index, tab) => MapEntry(
              index,
              Container(
                decoration: BoxDecoration(
                  color: model.currentIndex == index
                      ? getColor(type: ColorType.primary)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  leading: tab['title'] != "Settings"
                      ? Icon(
                          tab['icon'],
                          color: model.currentIndex == index
                              ? Colors.white
                              : Colors.black,
                        )
                      : Icon(CupertinoIcons.gear,
                          color: model.currentIndex == index
                              ? Colors.white
                              : Colors.black),
                  title: Text(
                    tab['title'],
                    style: TextStyle(
                        fontWeight: model.currentIndex == index
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: model.currentIndex == index
                            ? Colors.white
                            : Colors.black),
                  ),
                  onTap: () => model.setIndex(index),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  // trailing: tab['icon'],
                ),
              ),
            ),
          )
          .values
          .toList(),
    ]);
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

PageTransitionSwitcher _pageTransitionSwitcher({TabLayoutViewModel model}) {
  return PageTransitionSwitcher(
    duration: const Duration(milliseconds: 500),
    transitionBuilder: (
      Widget child,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) {
      return SharedAxisTransition(
        child: child,
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        transitionType: SharedAxisTransitionType.vertical,
      );
    },
    child: getViewForIndex(model.currentIndex),
  );
}

Widget getViewForIndex(index) {
  switch (index) {
    case 0:
      return HomeView();
    case 1:
      return UserListView();
    case 2:
      return SearchView();
    case 3:
      return ExploreView();
    case 4:
      return SettingsView();
    default:
      return HomeView();
  }
}
