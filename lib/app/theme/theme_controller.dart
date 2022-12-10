import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeAppController extends GetxController {

  @override
  void onInit() {
    print('init theme');
    getThemeStatus();

    super.onInit();
  }
  bool isLightTheme = false;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  saveThemeStatus() async {
    (await _prefs).setBool('theme', isLightTheme);
  }

  getThemeStatus() async {
    var isLight = _prefs.then((SharedPreferences prefs) {
      return prefs.getBool('theme') ?? true;
    });
    isLightTheme = await isLight;
    Get.changeThemeMode(isLightTheme ? ThemeMode.light : ThemeMode.dark);
    update();
  }

  tooggTheme() {
    isLightTheme = !isLightTheme;
    Get.changeThemeMode(
      isLightTheme ? ThemeMode.light : ThemeMode.dark,
    );
    saveThemeStatus();
    update();
  }
}
