import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:text/ui/navigations/main_navigation.dart';
import '../../../object/dish_object.dart';

class DishDetailedModel extends ChangeNotifier {
  int dishKey;
  late final Future<Box<Dish>> _dishBox;
  Dish? _dish;
  Dish? get dish => _dish;

  DishDetailedModel({required this.dishKey}) {
    _setup();
  }

  void showMenu(context) {
    Navigator.of(context).pop();
  }

  void showCart(context) {
    Navigator.of(context).pushNamed(MainNavigation().cart);
  }

  void toggFovarit() {
    _dish!.isFovarit = !_dish!.isFovarit;
    _dish!.save();
    notifyListeners();
  }

  void _load() async {
    final box = await _dishBox;
    _dish = box.get(dishKey);
    notifyListeners();
  }

  void _setup() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(DishAdapter());
    }
    _dishBox = Hive.openBox<Dish>('dish_box');
    _load();
  }
}
