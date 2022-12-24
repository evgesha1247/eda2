
import 'package:get/get.dart';


class GuidingController extends GetxController {

  int _currentIndexTab = 0;
  get currentIndexTab => _currentIndexTab;

  setCurrentIndexTab(int? index) {
    if (index != null) {
      _currentIndexTab = index;
      update();
    }
  }
}
