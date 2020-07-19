import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laradart/styles/button_text_style_constants.dart';
import 'package:laradart/styles/color_constants.dart';
import 'package:laradart/ui/views/tab_layout/tab_layout_viewmodel.dart';

class TabletScreen extends StatelessWidget {
  final TabLayoutViewModel model;

  TabletScreen({
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
                width: 75,
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
                            ? IconButton(
                                splashColor: getColor(type: ColorType.accent),
                                icon: Icon(
                                  Icons.exit_to_app,
                                  color: getColor(type: ColorType.primary),
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
      ...model.tabs
          .asMap()
          .map(
            (index, tab) => MapEntry(
              index,
              GestureDetector(
                onTap: () => model.setIndex(index),
                child: Container(
                  height: 50,
                  width: 50,
                  margin: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    color: model.currentIndex == index
                        ? getColor(type: ColorType.primary)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(
                        tab['title'] != "Settings" ? 15 : 25),
                  ),
                  child: Container(
                    child: tab['title'] != "Settings"
                        ? Icon(
                            tab['icon'],
                            color: model.currentIndex == index
                                ? Colors.white
                                : Colors.black,
                          )
                        : tab['icon'],
                  ),
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
