import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text/ui/widgets/auth/auth_widget.dart';
import '../screens/guiding_screen/guiding_model.dart';
import '../screens/guiding_screen/guiding_screen.dart';
import '../screens/menu_home_screen/menu_home_model.dart';
import '../screens/menu_home_screen/menu_home_screen.dart';
import '../widgets/auth/auth_widget_model.dart';

class ScreensFactory {
  Widget makeGuiding() => ChangeNotifierProvider(
        create: (context) => GuidingScreenModel(),
        child: const GuidingScreen(),
      );

  /////// страница регестрации  ///////
  Widget makeAuth() => ChangeNotifierProvider(
        create: (context) => AuthModel(),
        child: const AuthWidget(),
      );
  /////// основные страницы  ///////
  Widget makeMenuHome() => ChangeNotifierProvider(
        create: (context) => MenuHomeModel(),
        child: const MenuHomeScreen(),
      );
}
