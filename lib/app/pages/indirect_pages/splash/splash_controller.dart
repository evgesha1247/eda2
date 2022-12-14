import 'dart:async';

import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:text/helper/dependencies.dart';
import '../../../routes/main_routes.dart';



class SplashController extends GetxController {
  @override
  void onInit() {
    Timer(const Duration(seconds: 2), () {
      Get.offAndToNamed(MainRoutes.getGuiding);
    });

    super.onInit();
  }
}
