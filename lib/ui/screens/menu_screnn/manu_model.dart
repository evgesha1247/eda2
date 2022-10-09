import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../object/dish_object.dart';
import '../../navigations/main_navigation.dart';

class MenuModel extends ChangeNotifier {
  MenuModel() {
    _setup();
  }

  var _items = <Dish>[];
  List<Dish> get items => _items.toList();

  void _setup() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(DishAdapter());
    }
    final box = await Hive.openBox<Dish>('dish_box');
    _readDishData(box);
    box.listenable().addListener(() => _readDishData(box));
  }

  void _readDishData(Box<Dish> box) async {
    _items = box.values.toList();
    notifyListeners();
  }

  // void toggFovarit(int index) async {
  //   _items[index].isFovarit = !_items[index].isFovarit;
  //   await _items[index].save();
  //   notifyListeners();
  // }

  void showDetail(BuildContext context, int index) async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(DishAdapter());
    }
    final box = await Hive.openBox<Dish>('dish_box');
    final dishKey = box.keyAt(index);
    // ignore: use_build_context_synchronously
    await Navigator.of(context)
        .pushNamed(MainNavigationRouteName.details, arguments: dishKey);
  }
}
