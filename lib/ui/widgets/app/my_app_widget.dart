import 'package:flutter/material.dart';
import 'package:text/ui/navigations/main_navigation.dart';
import 'package:text/ui/theme/theme_app.dart';

class MyAppWidget extends StatelessWidget {
  const MyAppWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final mainNavigation = MainNavigation();
    return MaterialApp(
      title: 'flutter app',
      theme: ThemeData(
        fontFamily: 'Plankiss',
        scaffoldBackgroundColor: ThemeApp.kBGColor,
      ),
      routes: mainNavigation.routes,
      initialRoute: mainNavigation.initialRoute,
      onGenerateRoute: mainNavigation.onGenerateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
