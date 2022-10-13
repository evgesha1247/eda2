import 'package:flutter/material.dart';

import 'package:text/ui/screens/splesh_screen/splesh_screen.dart';
import 'package:text/ui/screens/cart_screen/cart_screen.dart';
import 'package:text/ui/screens/dish_detailed_screen/dish_detailed_screen.dart';
import '../screens_factory.dart/widget_factory.dart';

abstract class MainNavigationRouteName {
  static const guiding = '/guiding';
  static const auth = '/auth';
  static const details = '/guiding/details';
  static const cart = '/guiding/cart';
  static const splash = '/splash';
}


class MainNavigation {
  final _widgetFactory = ScreensFactory();
  final initialRoute = MainNavigationRouteName.splash;


  Map<String, WidgetBuilder> get routes => <String, WidgetBuilder>{
        MainNavigationRouteName.guiding: (_) => _widgetFactory.makeGuiding(),
        MainNavigationRouteName.auth: (_) => _widgetFactory.makeAuth(),
        // details: (_) => DishDetailedScreen(dishKey: null),
        MainNavigationRouteName.cart: (_) => const CartScreen(),
        MainNavigationRouteName.splash: (_) => const SplashScreen()
      };

  ////// при ошибке навигации //////
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteName.details:
        final dishKey = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) => DishDetailedScreen(dishKey: dishKey),
        );

      default:
        return MaterialPageRoute(
      builder: (context) => Scaffold(
        body: Center(child: Text('ошибка навигации ! , ${settings.name}')),
      ),
    );
    }
  }
}
