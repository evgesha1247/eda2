import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuidingScreenModel extends GetxController {
  var _currentIndexTab = 0;
  get currentIndexTab => _currentIndexTab;
  setCurrentIndexTab(int? index) {
    if (index != null) {
      _currentIndexTab = index;
      update();
    }
  }
}
