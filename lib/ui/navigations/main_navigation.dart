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
        MainNavigationRouteName.auth: (_) => _widgetFactory.makeAuth(),
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
