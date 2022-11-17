import 'package:get/get.dart';
import 'package:text/app/page/auth/auth_screen.dart';
import 'package:text/app/page/splash/splash_screen.dart';
import '../page/cart/cart_screen.dart';
import '../page/dish_detailed/dish_detailed_screen.dart';
import '../page/guiding/guiding_screen.dart';
import '../widgets/load/circular_widget.dart';
part 'main_routes.dart';

class MainScreens {
  MainScreens._();
  static const splash = MainRoutes.splash;
  static const load = MainRoutes.load;

  static final List<GetPage> getPages = [
    /// загрузка
    GetPage(name: _Paths.load, page: () => const CircularWidget()),
    GetPage(name: _Paths.splash, page: () => const SplashScreen()),

    GetPage(name: _Paths.appHome, page: () => const GuidingScreen()),
    GetPage(name: _Paths.auth, page: () => const AuthScreen()),
    GetPage(name: _Paths.detailsCart, page: () => CartScreen()),
    GetPage(name: _Paths.homeCart, page: () => CartScreen()),

    GetPage(
      name: _Paths.details,
      page: () => const DishDetailedScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 350),
    ),
  ];
}
