import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:text/ui/navigations/main_navigation.dart';
import '../../../box_menager/box_menager.dart';
import '../../../object/dish_object.dart';

class DishDetailedModel extends ChangeNotifier {
  DishDetailedModel({required this.dishKey}) {
    _setup();
  }
  int dishKey;
  late final Future<Box<Dish>> _box;
  Dish? _dish;
  Dish? get dish => _dish;

  void showMenu(context) => Navigator.of(context).pop();
  void showCart(context) =>
      Navigator.of(context).pushNamed(MainNavigationRouteName.cart);

  Future<void> _setup() async {
    _box = BoxManadger.instance.openBoxDish();
    _dish = (await _box).get(dishKey);
    notifyListeners();
  }


  Future<void> toggFovarit() async {
    final crrent = _dish?.isFavorit ?? false;
    _dish?.isFavorit = !crrent;
    await _dish?.save();
    notifyListeners();
  }



}
