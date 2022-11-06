import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/theme/theme_app.dart';
import 'package:flutter/services.dart';

import '../../routes/main_screens.dart';

class MyAppWidget extends StatelessWidget {
  const MyAppWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    return GetMaterialApp(
      title: 'Restaurant',
      theme: ThemeData(
        fontFamily: 'Mariupol',
        scaffoldBackgroundColor: ThemeAppColor.kBGColor,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      getPages: MainScreens.getPages,
      initialRoute: MainScreens.load,
    );
  }
}
