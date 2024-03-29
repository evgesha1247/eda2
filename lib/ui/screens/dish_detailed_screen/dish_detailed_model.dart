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
  Dish? _dish;
  Dish? get dish => _dish;
  late final Future<Box<Dish>> _box;


  void showMenu(context) => Navigator.of(context).pop();

  Future<void> _setup() async {
    _box = BoxManadger.instance.openBoxDish();
    _dish = (await _box).get(dishKey);
    notifyListeners();
  }
showCart(context) =>
      Navigator.pushNamed(context, MainNavigationRouteName.cart);

  Future<void> toggFovarit() async {
    dish!.isFavorit = !dish!.isFavorit;
    await dish!.save();
    notifyListeners();
  }

}
