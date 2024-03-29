import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../box_menager/box_menager.dart';
import '../../../object/dish_object.dart';

class FavoriteModel extends ChangeNotifier {

  FavoriteModel() {
    _setup();
  }
  late final Future<Box<Dish>> _box;
  final _itemsFovarit = <Dish>[];
  List<Dish> get itemsFovarit => _itemsFovarit.toList();

  Future<void> _setup() async {
    _box = BoxManadger.instance.openBoxDish();
    await _loadFavoritDish();
    (await _box).listenable().addListener(_loadFavoritDish);
  }


  Future<void> _loadFavoritDish() async {
    for (var element in (await _box).values) {
      if (element.isFavorit && !_itemsFovarit.contains(element)) {
        _itemsFovarit.add(element);
      } else if (!element.isFavorit) {
        _itemsFovarit.remove(element);
      }
    }
    notifyListeners();
  }
}
