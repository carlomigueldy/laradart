import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../styles/button_text_style_constants.dart';
import '../../../../../styles/color_constants.dart';
import '../../tab_layout_viewmodel.dart';

class DesktopScreen extends StatelessWidget {
  final TabLayoutViewModel model;

  DesktopScreen({
    this.model,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
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
                  child: pageTransitionSwitcher(model: model),
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

PageTransitionSwitcher pageTransitionSwitcher({TabLayoutViewModel model}) {
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
    child: model.getViewForIndex(model.currentIndex),
  );
}
