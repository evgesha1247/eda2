import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/ui/navigations/main_navigation.dart';
import 'package:text/ui/theme/theme_app.dart';

import 'package:flutter/services.dart';

class MyAppWidget extends StatelessWidget {
  const MyAppWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    final mainNavigation = MainNavigation();
    return GetMaterialApp(
      title: 'flutter app',
      theme: ThemeData(
        fontFamily: 'Mariupol',
        scaffoldBackgroundColor: ThemeAppColor.kBGColor,
        useMaterial3: true,
      ),
      routes: mainNavigation.routes,
      initialRoute: mainNavigation.initialRoute,
      onGenerateRoute: mainNavigation.onGenerateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
