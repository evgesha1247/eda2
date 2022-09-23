import 'package:flutter/material.dart';
import '../screens_factory.dart/widget_factory.dart';

abstract class MainNavigationRouteName {
  static const guiding = '/guiding';
  static const auth = '/auth';
  static const details = '/guiding/details';
  static const cart = '/guiding/cart';
}

class MainNavigation {
  final _widgetFactory = ScreensFactory();
  final initialRoute = MainNavigationRouteName.guiding;
  final guiding = MainNavigationRouteName.guiding;
  final auth = MainNavigationRouteName.auth;
  final details = MainNavigationRouteName.details;
  final cart = MainNavigationRouteName.cart;
  Map<String, WidgetBuilder> get routes => <String, WidgetBuilder>{
        guiding: (_) => _widgetFactory.makeGuiding(),
        auth: (_) => _widgetFactory.makeAuth(),
        details: (_) => _widgetFactory.makeDetailed(),
        cart: (_) => _widgetFactory.makeCart(),
      };

  ////// при ошибке навигации //////
  Route? onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        body: Center(child: Text('ошибка навигации ! , ${settings.name}')),
      ),
    );
  }
}
