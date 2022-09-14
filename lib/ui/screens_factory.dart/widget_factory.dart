import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text/ui/screens/menu_screnn/menu_model.dart';
import 'package:text/ui/screens/menu_screnn/menu_screen.dart';
import 'package:text/ui/widgets/auth/auth_widget.dart';
import '../screens/favorite/favorite_model.dart';
import '../screens/favorite/favorite_screen.dart';
import '../screens/guiding_screen/guiding_model.dart';
import '../screens/guiding_screen/guiding_screen.dart';
import '../screens/home_screen/home_model.dart';
import '../screens/home_screen/home_screen.dart';
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
  //////////////////////////////////////
  ////// основные страницы меню  //////
  Widget makeHome() => ChangeNotifierProvider(
        create: (context) => HomeModel(),
        child: const HomeScreen(),
      );
  Widget makeMenu() => ChangeNotifierProvider(
        create: (context) => MenuModel(),
        child: const MenuScreen(),
      );
  Widget makeFavorit() => ChangeNotifierProvider(
        create: (context) => FavoriteModel(),
        child: const FavoriteScrenn(),
      );
  //////////////////////////////////////
  /////////////////////////////////////
}
