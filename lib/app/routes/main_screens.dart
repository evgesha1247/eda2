import 'package:get/get.dart';
import 'package:text/app/factory/widget_factory.dart';
import 'package:text/app/model/guiding/guiding_binding.dart';
import 'package:text/app/model/splash/splash_binding.dart';

import '../model/dish_detailed/dish_detailed_screen.dart';
import '../model/guiding/guiding_screen.dart';
import '../widgets/load/circular_widget.dart';
part 'main_routes.dart';

class MainScreens {
  MainScreens._();
  static const splash = MainRoutes.splash;
  static const load = MainRoutes.load;
  static final List<GetPage> getPages = [
    /// загрузка
    GetPage(
      name: _Paths.load,
      page: () => const CircularWidget(),
    ),
    GetPage(
      name: _Paths.splash,
      page: () => ScreensFactory.instance.makeSplash(),
        binding: SplashBindings()
    ),


    GetPage(
      name: _Paths.appHome,
      page: () => const GuidingScreen(),
      binding: GuidingBindings(),
    ),
    GetPage(
      name: _Paths.auth,
      page: () => ScreensFactory.instance.makeAuth(),

    ),
    GetPage(
      name: _Paths.cart,
      page: () => ScreensFactory.instance.makeCart(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 350),
    ),
    GetPage(
      name: _Paths.details,
      page: () => DishDetailedScreen(dishKey: Get.arguments),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 350),
    ),
  ];
}
