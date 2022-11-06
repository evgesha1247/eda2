import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import '../data/object/cart_object.dart';
import '../data/object/dish_object.dart';
import '../model/auth/auth_model.dart';
import '../model/auth/auth_screen.dart';
import '../model/cart/cart_screen.dart';
import '../model/favorite/favorite_model.dart';
import '../model/favorite/favorite_screen.dart';
import '../model/guiding/guiding_model.dart';
import '../model/guiding/guiding_screen.dart';
import '../model/home/home_screen.dart';
import '../model/menu/menu_screen.dart';
import '../model/profile/profile_screen.dart';
import '../model/splash/splash_screen.dart';
import '../widgets/app/my_app_widget.dart';

class ScreensFactory {
  static final instance = ScreensFactory._();
  ScreensFactory._();
  Widget makeMainApp() => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => CartModel()),
          ChangeNotifierProvider(create: (context) => DishModel()),
        ],
        child: const MyAppWidget(),
      );

  /////// страница регестрации  ///////
  Widget makeAuth() => ChangeNotifierProvider(
        create: (context) => AuthModel(),
        child: const AuthScreen(),
      );
  Widget makeFavorite() => ChangeNotifierProvider(
        create: (context) => FavoriteModel(),
        child: const FavoriteScreen(),
      );
  /////////
  Widget makeCart() => const CartScreen();
  Widget makeSplash() => const SplashScreen();
  Widget makeHome() => const HomeScreen();
  Widget makeMenu() => const MenuScreen();
  Widget makeProfile() => const ProfileScreen();
}
