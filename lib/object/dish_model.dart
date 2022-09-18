import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../object/dish_object.dart';

class DishModel extends ChangeNotifier {
  DishModel() {
    _setup();
  }
  var _items = <Dish>[];
  List<Dish> get items => _items.toList();
  void _readBoxDishsFromHive(Box<Dish> box) {
    // final a = Dish(
    //     name: 'qweqwe',
    //     price: 89.4,
    //     imgUrl: 'assets/imgs/food3.png',
    //     description:
    //         'orem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu');
    // box.add(a);
    _items = box.values.toList();
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
