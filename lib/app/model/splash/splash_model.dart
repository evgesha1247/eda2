import 'package:get/get.dart';

import '../../routes/main_screens.dart';

class SplashModel extends GetxController {
  static get model => Get.find()<SplashModel>();
  @override
  void onInit() {
    showHome();
    super.onInit();
  }

  void showHome() {
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(MainRoutes.appHome);
    });
  }
}
