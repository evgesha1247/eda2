import 'package:get/get.dart';
import 'package:text/app/factory/widget_factory.dart';

import '../model/dish_detailed/dish_detailed_screen.dart';
import '../model/guiding/guiding_screen.dart';
import '../widgets/load/circular_widget.dart';

part 'main_routes.dart';

class MainScreens {
  MainScreens._();
  static const splash = MainRoutes.splash;
  static const load = MainRoutes.load;
  static final List<GetPage> getPages = [
    GetPage(
      name: _Paths.splash,
      page: () => ScreensFactory.instance.makeSplash(),
    ),
    GetPage(
      name: _Paths.load,
      page: () => const CircularWidget(),
    ),
    GetPage(name: _Paths.appHome, page: () => const GuidingScreen()),
    GetPage(
      name: _Paths.auth,
      page: () => ScreensFactory.instance.makeAuth(),
    ),
    GetPage(
      name: _Paths.cart,
      page: () => ScreensFactory.instance.makeCart(),
    ),
    GetPage(
      name: _Paths.details,
      page: () => DishDetailedScreen(dishKey: Get.arguments),
    ),
  ];
}
