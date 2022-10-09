import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../object/dish_object.dart';

class FavoriteModel extends ChangeNotifier {
  final _itemsFovarit = <Dish>[];
  List<Dish> get itemsFovarit => _itemsFovarit.toList();

  FavoriteModel() {
    _setup();
  }

  void _setup() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(DishAdapter());
    }
    final box = await Hive.openBox<Dish>('dish_box');
    _loadFavoritDish(box);
    box.listenable().addListener(() => _loadFavoritDish(box));
  }

  void _loadFavoritDish(Box<Dish> box) {
    for (var element in box.values) {
      if (element.isFavorit && !_itemsFovarit.contains(element)) {
        _itemsFovarit.add(element);
      } else if (!element.isFavorit) {
        _itemsFovarit.remove(element);
      }
    }
    notifyListeners();
  }
}
