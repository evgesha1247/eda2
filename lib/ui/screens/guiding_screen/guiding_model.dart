import 'package:flutter/material.dart';

class GuidingScreenModel extends ChangeNotifier {
  var _currentIndexTab = 0;
  int get currentIndexTab => _currentIndexTab;
  setCurrentIndexTab(int? index) {
    if (index != null) {
      _currentIndexTab = index;
      notifyListeners();
    }
  }
}
