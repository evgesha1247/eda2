import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:text/ui/navigations/main_navigation.dart';
import '../../../object/dish_object.dart';

class DishDetailedModel extends ChangeNotifier {
  DishDetailedModel({required this.dishKey}) {
    _setupDetailed();
  }
  int dishKey;
  late final Future<Box<Dish>> _dishBox;
  Dish? _dish;
  Dish? get dish => _dish;



  void showMenu(context) => Navigator.of(context).pop();
  void showCart(context) =>
      Navigator.of(context).pushNamed(MainNavigation().cart);


  void toggFovarit() async {
    final crrent = _dish?.isFovarit ?? false;
    _dish?.isFovarit = !crrent;
    await _dish?.save();
    notifyListeners();
  }


  void _setupDetailed() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(DishAdapter());
    }
    _dishBox = Hive.openBox<Dish>('dish_box');
    _loadDetailed();
  }
  void _loadDetailed() async {
    _dish = (await _dishBox).get(dishKey);
    notifyListeners();
  }
}
