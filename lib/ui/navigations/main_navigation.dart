import 'package:get/get.dart';
import 'package:text/ui/screens/dish_detailed_screen/dish_detailed_screen.dart';
import '../screens_factory.dart/widget_factory.dart';

abstract class MainNavigationRouteName {
  static const splash = '/splash';
  static const guiding = '/guiding';
  static const auth = '/auth';
  static const details = '/guiding/details';
  static const cart = '/guiding/cart';
}

class MainNavigation {
  List<GetPage> getPages = [
    GetPage(
      name: MainNavigationRouteName.splash,
      page: () => ScreensFactory.instance.makeSplash(),
    ),
    GetPage(
      name: MainNavigationRouteName.guiding,
      page: () => ScreensFactory.instance.makeGuiding(),
    ),
    GetPage(
      name: MainNavigationRouteName.auth,
      page: () => ScreensFactory.instance.makeAuth(),
    ),
    GetPage(
      name: MainNavigationRouteName.cart,
      page: () => ScreensFactory.instance.makeCart(),
    ),
    GetPage(
      name: MainNavigationRouteName.details,
      page: () => DishDetailedScreen(dishKey: Get.arguments),
    ),
  ];
}
