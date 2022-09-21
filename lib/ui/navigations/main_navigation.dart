import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../object/dish_object.dart';
import '../screens_factory.dart/widget_factory.dart';

abstract class MainNavigationRouteName {
  static const guiding = '/guiding';
  static const auth = '/auth';
  static const details = '/guiding/details';
}

class MainNavigation {
  final _widgetFactory = ScreensFactory();
  final initialRoute = MainNavigationRouteName.guiding;
  final guiding = MainNavigationRouteName.guiding;
  final auth = MainNavigationRouteName.auth;
  final details = MainNavigationRouteName.details;
  Map<String, WidgetBuilder> get routes => <String, WidgetBuilder>{
        guiding: (_) => _widgetFactory.makeGuiding(),
        auth: (_) => _widgetFactory.makeAuth(),
        details: (_) => _widgetFactory.makeDetailed(),
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
