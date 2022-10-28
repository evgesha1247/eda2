import 'package:flutter/material.dart';
import 'package:text/ui/screens/cart_screen/cart_screen.dart';
import 'package:text/ui/screens/dish_detailed_screen/dish_detailed_screen.dart';
import '../screens/splash_screen/splash_screen.dart';
import '../screens_factory.dart/widget_factory.dart';

abstract class MainNavigationRouteName {
  static const guiding = '/guiding';
  static const auth = '/auth';
  static const details = '/guiding/details';
  static const cart = '/guiding/cart';
  static const splash = '/splash';
  static const login = '/login';
  static const register = '/register';
}


class MainNavigation {
  final _widgetFactory = ScreensFactory();
  final initialRoute = MainNavigationRouteName.guiding;


  Map<String, WidgetBuilder> get routes => <String, WidgetBuilder>{
        MainNavigationRouteName.guiding: (_) => _widgetFactory.makeGuiding(),
        MainNavigationRouteName.auth: (_) => _widgetFactory.makeAuth(),
        MainNavigationRouteName.cart: (_) => const CartScreen(),
        MainNavigationRouteName.splash: (_) => const SplashScreen(),

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
