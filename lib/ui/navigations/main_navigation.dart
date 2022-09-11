import 'package:flutter/material.dart';
import '../screens_factory.dart/widget_factory.dart';

abstract class MainNavigationRouteName {
  static const guiding = '/guiding';
  static const auth = '/auth';
}

class MainNavigation {
  final _widgetFactory = ScreensFactory();
  final initialRoute = MainNavigationRouteName.guiding;

  Map<String, WidgetBuilder> get routes => <String, WidgetBuilder>{
        MainNavigationRouteName.guiding: (_) => _widgetFactory.makeGuiding(),
        MainNavigationRouteName.auth: (contest) => _widgetFactory.makeAuth(),
      };

  ////// при ошибке навигации //////
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      default:
        MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('ошибка навигации !'),
            ),
          ),
        );
    }
    return null;
  }
}
