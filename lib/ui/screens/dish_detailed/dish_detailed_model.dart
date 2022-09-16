import 'package:flutter/material.dart';

class DishDetailedModel extends ChangeNotifier {
  int dishKey;
  DishDetailedModel({required this.dishKey});

  void showMenu(context) {
    Navigator.of(context).pop();
  }
}
