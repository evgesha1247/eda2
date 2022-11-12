import 'package:get/get.dart';

import '../../routes/main_screens.dart';

class SplashModel extends GetxController {
  @override
  void onInit() {
    print('object');
    showHome();
    super.onInit();
  }

  void showHome() {
    Future.delayed(const Duration(seconds: 4), () {
      Get.offAllNamed(MainRoutes.appHome);
    });
  }
}
