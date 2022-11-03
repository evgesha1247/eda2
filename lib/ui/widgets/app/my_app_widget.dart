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
      home: const _Home(),
      onGenerateRoute: mainNavigation.onGenerateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}


class _Home extends StatelessWidget {
  const _Home();
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
