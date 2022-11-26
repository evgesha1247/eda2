import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/pages/indirect_pages/auth/auth_screen.dart';
import 'package:text/app/pages/indirect_pages/cart/cart_page.dart';
import 'package:text/app/pages/indirect_pages/detailed/food_detailed.dart';
import 'package:text/app/pages/indirect_pages/splash/splash_screen.dart';
import '../pages/indirect_pages/profile/profile_screen.dart';
import '../pages/primary_pages/guiding/guiding_screen.dart';
import '../widgets/load/circular.dart';

class MainRoutes {
  MainRoutes._();

  static const _initial = '/';
  static const _auth = '/auth';
  static const _splash = '/auth/splash';
  static const _main = '/splash/main';
  static const _cart = '/main/cart';
  static const _profile = '/main/profile';
  static const _detailed = '/main/detailed-food';

  static String getInitial() => _initial;
  static String getAuth() => _auth;
  static String getSplash() => _splash;
  static String getMain() => _main;
  static String getCart() => _cart;
  static String getProfile() => _profile;

  static String getDetailed(pageID) => '$_detailed?pageID=$pageID';

  static final List<GetPage> getPages = [
    /// загрузка
    GetPage(name: _initial, page: () => const Scaffold(body: CircularWidget())),

    GetPage(name: _splash, page: () => const SplashScreen()),
    //
    GetPage(name: _auth, page: () => const AuthScreen()),
    //
    GetPage(name: _main, page: () => const GuidingScreen()),
    GetPage(name: _cart, page: () => const CartPage()),
    GetPage(name: _detailed, page: () => FoodDetailedPage()),
    GetPage(name: _profile, page: () => const ProfilePage()),

  ];
}
