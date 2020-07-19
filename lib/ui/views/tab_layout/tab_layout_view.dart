import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

import './tab_layout_viewmodel.dart';
import './tabs/screens/desktop_screen.dart';
import './tabs/screens/mobile_screen.dart';
import './tabs/screens/tablet_screen.dart';

class TabLayoutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TabLayoutViewModel>.reactive(
      viewModelBuilder: () => TabLayoutViewModel(),
      builder: (context, model, child) {
        return ScreenTypeLayout(
          mobile: MobileScreen(model: model),
          desktop: DesktopScreen(model: model),
          tablet: TabletScreen(model: model),
        );
      },
    );
  }
}
