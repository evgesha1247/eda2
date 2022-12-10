import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/pages/indirect_pages/auth/auth_screen.dart';
import 'package:text/app/pages/indirect_pages/cart/cart_page.dart';
import 'package:text/app/pages/indirect_pages/detailed/food_detailed.dart';
import 'package:text/app/pages/indirect_pages/splash/splash_screen.dart';
import '../../helper/dependencies.dart';
import '../pages/indirect_pages/profile/profile_page.dart';
import '../pages/primary_pages/guiding/guiding_screen.dart';
import '../widgets/load/circular.dart';

class MainRoutes {
  MainRoutes._();

  static const getInitial = '/';
  static const getAuth = '/auth';
  static const getSplash = '/splash';

  static const getGuiding = '/guiding';
  static const getCart = '/guiding/cart';
  static const getProfile = '/guiding/profile';

  static const _detailed = '/guiding/detailed-food';
  static String getDetailed(pageID) => '$_detailed?pageID=$pageID';

  static final List<GetPage> getPages = [
    /// загрузка
    GetPage(
      name: getInitial,
      page: () => const Scaffold(
        body: CircularWidget(),
      ),
    ),

    GetPage(name: getSplash, page: () => const SplashPage()),

    GetPage(name: getAuth, page: () => const AuthPage()),

    GetPage(name: getCart, page: () => const CartPage()),
    GetPage(name: _detailed, page: () => FoodDetailedPage()),
    GetPage(name: getProfile, page: () => ProfilePage()),

    GetPage(name: getGuiding, page: () => const GuidingPage()),
  ];
}
