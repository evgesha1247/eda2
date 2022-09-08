import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/guiding_screen/guiding_model.dart';
import '../screens/guiding_screen/guiding_screen.dart';
import '../screens/menu_home_screen/menu_home_model.dart';
import '../screens/menu_home_screen/menu_home_screen.dart';

class ScreensFactory {
  Widget makeGuiding() => ChangeNotifierProvider(
        create: (context) => GuidingScreenModel(),
        child: const GuidingScreen(),
      );

  /////// SCREENS ///////
  Widget makeMenuHome() => ChangeNotifierProvider(
        create: (context) => MenuHomeModel(),
        child: const MenuHomeScreen(),
      );
}
