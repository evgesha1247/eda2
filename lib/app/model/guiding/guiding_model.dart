import 'package:get/get.dart';
import '../../data/object/dish_object.dart';
import '../../routes/main_screens.dart';

class GuidingScreenModel extends GetxController {
  var _currentIndexTab = 0;
  get currentIndexTab => _currentIndexTab;

  setCurrentIndexTab(int? index) {
    if (index != null) {
      _currentIndexTab = index;
      update();
    }
  }
  void showDetail(Dish item) {
    Get.toNamed(MainRoutes.details, arguments: {'item': item});
  }
}
