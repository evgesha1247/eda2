import 'package:get/get.dart';
import 'package:text/helper/dependencies.dart';
import '../../../theme/theme_controller.dart';

class SplashController {

  Future<void> loadData() async {
    await ThemeBindings().dependencies();
    Get.find<ThemeAppController>().getThemeStatus();
    await ControllersBindings().dependencies();
    await DataBindings().dependencies();
    await AllPageBindings().dependencies();
  }
}
