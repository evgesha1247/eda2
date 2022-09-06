import 'package:flutter/material.dart';

class HomeModel extends ChangeNotifier {
  bool _togFilter = false;
  get togFilter => _togFilter;
  togFilterFun() {
    _togFilter = !_togFilter;

    notifyListeners();
  }
}
