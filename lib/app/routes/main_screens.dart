import 'package:get/get.dart';
import 'package:text/app/page/auth/auth_screen.dart';
import 'package:text/app/page/cart/cart_screen.dart';
import 'package:text/app/page/splash/splash_screen.dart';
import '../page/detailed/popular_detailed_page.dart';
import '../page/guiding/guiding_screen.dart';
import '../widgets/load/circular_widget.dart';


class MainRoutes {
  MainRoutes._();

  static const _initial = '/';
  static const _auth = '/auth';
  static const _splash = '/auth/splash';
  static const _main = '/splash/main';
  static const _cart = '/main/cart';
  static const _popularFood = '/main/popular-food';
  static const _recommerndedFood = '/main/recommernded-food';

  static String getInitial() => _initial;
  static String getAuth() => _auth;
  static String getSplash() => _splash;
  static String getMain() => _main;
  static String getCart() => _cart;
  static String getPopularFood(int pageID) => '$_popularFood?pageID=$pageID';
  static String getRecommerndedFood() => _recommerndedFood;

  static final List<GetPage> getPages = [
    /// загрузка
    GetPage(name: _initial, page: () => const CircularWidget()),
    GetPage(name: _splash, page: () => const SplashScreen()),
    //
    GetPage(name: _auth, page: () => const AuthScreen()),
    //
    GetPage(name: _main, page: () => const GuidingScreen()),
    GetPage(name: _cart, page: () => const CartScreen()),
    GetPage(
      name: _popularFood,
      page: () {
        var pageID = Get.parameters['pageID'];
        return PopularDetailedPage(
          pageID: int.parse(pageID!),
        );
      },

    ),

  ];
}
