import 'package:flutter/material.dart';

class MenuHomeModel extends ChangeNotifier {
  bool _togFilter = true;
  get togFilter => _togFilter;
  togFilterFun() {
    _togFilter = !_togFilter;

    notifyListeners();
  }
}
