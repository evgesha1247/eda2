import 'package:flutter/material.dart';
import 'package:text/object/dish_model.dart';

class MenuModel extends DishModel {
  bool isFovarit = false;

  void toggIsFov() {
    isFovarit = !isFovarit;
    notifyListeners();
  }

  void addFavorit(int index) {
    toggIsFov();
  }
}
