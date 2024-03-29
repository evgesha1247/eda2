import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/ui/navigations/main_navigation.dart';
import 'package:text/ui/theme/theme_app.dart';

import 'package:flutter/services.dart';

import 'dart:async';
import 'package:flutter/foundation.dart';

import 'package:firebase_core/firebase_core.dart';

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
      ),
      routes: mainNavigation.routes,
      initialRoute: mainNavigation.initialRoute,
      onGenerateRoute: mainNavigation.onGenerateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
