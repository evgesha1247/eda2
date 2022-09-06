import 'package:flutter/material.dart';
import '../screens/screens_factory.dart/widget_factory.dart';

abstract class MainNavigationRouteName {
  static const main = '/';
}

class MainNavigation {
  final _widgetFactory = ScreensFactory();
  final initialRoute = MainNavigationRouteName.main;

  Map<String, WidgetBuilder> get routes => <String, WidgetBuilder>{
        MainNavigationRouteName.main: (_) => _widgetFactory.makeHomeApp(),
      };
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
