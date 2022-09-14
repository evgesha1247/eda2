import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import '../../../object/dish_object.dart';

class MenuModel extends ChangeNotifier {
  MenuModel() {
    _setup();
  }
  var _menuDishs = <Dish>[];
  List<Dish> get menuDishs => _menuDishs.toList();
  void _readBoxDishsFromHive(Box<Dish> box) {
    _menuDishs = box.values.toList();
    notifyListeners();
  }

  void _setup() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(DishAdapter());
    }
    final box = await Hive.openBox<Dish>('dish_box');
    _readBoxDishsFromHive(box);
    box.listenable().addListener(() {
      _readBoxDishsFromHive(box);
    });
  }

  void addToBox() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(DishAdapter());
    }
    final box = await Hive.openBox<Dish>('dish_box');
    box.close();
  }
}
