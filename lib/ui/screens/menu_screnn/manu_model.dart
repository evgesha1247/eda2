import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../box_menager/box_menager.dart';
import '../../../object/dish_object.dart';
import '../../navigations/main_navigation.dart';

class MenuModel extends ChangeNotifier {
  MenuModel() {
    _setup();
  }
  late final Future<Box<Dish>> _box;

  var _items = <Dish>[];
  List<Dish> get items => _items;
  var _itemsFilter = <Dish>[];
  List<Dish> get itemsFilter => _itemsFilter;

  Future<void> _setup() async {
    _box = BoxManadger.instance.openBoxDish();
    await _readDishData();
    (await _box).listenable().addListener(_readDishData);
  }


  Future<void> _readDishData() async {
    _items = (await _box).values.toList();
    _itemsFilter = _items;
    notifyListeners();
  }


  void filter({String dishCategory = ''}) {
    if (dishCategory != 'reset') {
      _itemsFilter = [];
      _items
          .where((e) => e.category == dishCategory)
          .map((e) => _itemsFilter.add(e))
          .toList();
    } else {
      _itemsFilter = _items;
    }
    notifyListeners();
  }

  searchFilter(String text) {
    if (text.isNotEmpty) {
_itemsFilter = [];
      _itemsFilter = _items
          .where((element) =>
              element.name.toLowerCase().contains(RegExp(text.toLowerCase())))
          .toList();
    } else {
      _itemsFilter = _items;
    }
    notifyListeners();
  }



  Future<void> toggFovarit(Dish item) async {
    for (var element in (await _box).values) {
      if (element == item) {
        element.isFavorit = !element.isFavorit;
        item.save();
      }
    }
    notifyListeners();
  }


  Future<void> showDetail(BuildContext context, Dish item) async {
    for (var element in (await _box).values) {
      if (element == item) {
        Navigator.of(context).pushNamed(
          MainNavigationRouteName.details,
          arguments: element.key,
        );
      }
    }
  }

  showCart(context) =>
      Navigator.pushNamed(context, MainNavigationRouteName.cart);
}
