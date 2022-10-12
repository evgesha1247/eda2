import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text/object/cart_object.dart';
import 'package:text/ui/screens/home_screen/home_screen.dart';
import 'package:text/ui/screens/profile_screen/profile_screen.dart';

import 'package:text/ui/widgets/auth/auth_widget.dart';
import 'package:text/ui/widgets/header_widget/header_model.dart';
import 'package:text/ui/widgets/header_widget/header_widget.dart';
import '../../object/dish_object.dart';

import '../screens/favorite_screen/favorite_model.dart';
import '../screens/favorite_screen/favorite_screen.dart';
import '../screens/guiding_screen/guiding_model.dart';
import '../screens/guiding_screen/guiding_screen.dart';

import '../screens/home_screen/home_model.dart';
import '../screens/menu_screnn/manu_model.dart';
import '../screens/menu_screnn/menu_screen.dart';
import '../widgets/app/my_app_widget.dart';
import '../widgets/auth/auth_widget_model.dart';

class ScreensFactory {
  Widget makeMainApp() => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => CartModel()),
          ChangeNotifierProvider(create: (context) => DishModel()),
        ],
        child: const MyAppWidget(),
      );
  Widget makeGuiding() => ChangeNotifierProvider(
        create: (context) => GuidingScreenModel(),
        child: const GuidingScreen(),
      );
  /////// страница регестрации  ///////
  Widget makeAuth() => ChangeNotifierProvider(
        create: (context) => AuthModel(),
        child: const AuthWidget(),
      );
  Widget makeHeder() => ChangeNotifierProvider(
        create: (context) => HeaderModel(),
        child: const HederWidget(),
      );
  /////////
  Widget makeHome() => ChangeNotifierProvider(
        create: (context) => HomeModel(),
        child: const HomeScreen(),
      );
  Widget makeMenu() => ChangeNotifierProvider(
        create: (context) => MenuModel(),
        child: const MenuScreen(),
      );
  Widget makeFavorite() => ChangeNotifierProvider(
        create: (context) => FavoriteModel(),
        child: const FavoriteScreen(),
      );
  Widget makeProfile() => const ProfileScreen();
}
