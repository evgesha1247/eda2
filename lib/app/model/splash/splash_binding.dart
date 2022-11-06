import 'package:get/get.dart';
import 'package:text/app/model/splash/splash_model.dart';

class SplashBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashModel>(SplashModel());
  }
}
