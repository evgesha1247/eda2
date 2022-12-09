import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../routes/main_routes.dart';
import '../../../widgets/text/my_text.dart';

class GuidingController extends GetxController {
  GuidingController() {
    print('init GuidingController');
  }
  var _currentIndexTab = 0;
  get currentIndexTab => _currentIndexTab;

  setCurrentIndexTab(int? index) {
    if (index != null) {
      _currentIndexTab = index;
      update();
    }
  }
}
