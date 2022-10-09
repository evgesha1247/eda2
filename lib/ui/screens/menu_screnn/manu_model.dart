import 'package:flutter/cupertino.dart';

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


  Future<void> _setup() async {
    _box = BoxManadger.instance.openBoxDish();
    _readDishData();
    (await _box).listenable().addListener(_readDishData);
  }



  Future<void> _readDishData() async {
    _items = (await _box).values.toList();
    notifyListeners();
  }

  Future<void> toggFovarit(int index) async {
    final box = (await _box).values.toList()[index];
    box.isFavorit = !box.isFavorit;
    box.save();
    notifyListeners();
  }

  Future<void> showDetail(BuildContext context, int index) async {
    Navigator.of(context).pushNamed(MainNavigationRouteName.details,
        arguments: (await _box).keyAt(index));
  }
}
