import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import '../../data/box_menager/box_menager.dart';
import '../../data/object/dish_object.dart';

class HomeModel extends GetxController {
  static HomeModel get model => Get.find();
  late final Future<Box<Dish>> _box;
  final _itemsHotDish = <Dish>[];
  List<Dish> get itemsHotDish => _itemsHotDish.toList();
  final _itemsMainCourse = <Dish>[];
  List<Dish> get itemsMainCourse => _itemsMainCourse.toList();
  @override
  void onInit() {
    _setup();
    super.onInit();
  }

  Future<void> _setup() async {
    _box = BoxManadger.instance.openBoxDish();
    await _readDishData();
    (await _box).listenable().addListener(_readDishData);
  }

  Future<void> _readDishData() async {
    _loadHotDish();
    _loadMainCourse();
  }

  Future<void> _loadHotDish() async {
    for (var element in (await _box).values) {
      if (element.isHot && !_itemsHotDish.contains(element)) {
        if (_itemsHotDish.length >= 3) {
          _itemsHotDish.remove(_itemsHotDish.first);
          _itemsHotDish.add(element);
        } else {
          _itemsHotDish.add(element);
        }
      }
      if (!element.isHot) {
        _itemsHotDish.remove(element);
      }
    }
    update();
  }

  Future<void> _loadMainCourse() async {
    for (var element in (await _box).values) {
      if (element.category == DishCategory.mainCourse &&
          !_itemsMainCourse.contains(element)) {
        _itemsMainCourse.add(element);
      }
      if (element.category != DishCategory.mainCourse) {
        _itemsMainCourse.remove(element);
      }
    }
    update();
  }
}
