// ignore_for_file: avoid_print
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import '../../data/box_menager/box_menager.dart';
import '../../data/object/dish_object.dart';
import '../../routes/main_screens.dart';

class HomeModel extends GetxController {
  late final User? user;
  late final Future<Box<Dish>> _box;
  late final RxObjectMixin<List<Dish>> _itemsHotDish = (<Dish>[]).obs;
  late final RxObjectMixin<List<Dish>> _itemPopular = (<Dish>[]).obs;
  List<Dish> get itemsHotDish => _itemsHotDish.value;
  List<Dish> get itemPopular => _itemPopular.value;

  late final RxString _titleText = (user?.displayName != null
          ? 'Hello ${user?.displayName ?? ''} '
          : 'Welcom back')
      .obs;

  get titleText => _titleText.value;


  late List<bool> selected =
      List.generate(_itemPopular.value.length, (i) => false).obs;
  @override
  onInit() {
    _setup();
    super.onInit();
  }

  Future<void> _setup() async {
    _box = BoxManadger.instance.openBoxDish();
    try {
      user = FirebaseAuth.instance.currentUser as User;
    } catch (e) {
      user = null;
    }
    await _readDishData();
    (await _box).listenable().addListener(_readDishData);
  }

  Future<void> _readDishData() async {
    _loadHotDish();
    _loadPopularItems();
  }

  Future<void> _loadHotDish() async {
    for (var element in (await _box).values) {
      if (element.isHot && !_itemsHotDish.value.contains(element)) {
        if (_itemsHotDish.value.length >= 3) {
          _itemsHotDish.value.remove(_itemsHotDish.value.first);
          _itemsHotDish.value.add(element);
        } else {
          _itemsHotDish.value.add(element);
        }
      } else if (!element.isHot && _itemsHotDish.value.contains(element)) {
        _itemsHotDish.value.remove(element);
      }
    }
    _itemsHotDish.refresh();
  }

  Future<void> _loadPopularItems() async {
    final box = (await _box);
    int n = box.values.length > 3 ? 3 : box.values.length;
    while (_itemPopular.value.length != n) {
      Dish? item = box.getAt(Random().nextInt(box.length - 1));
      if (!_itemPopular.value.contains(item)) {
        _itemPopular.value.add(item as Dish);
      }
    }
    _itemPopular.refresh();
  }

  void showDetail(Dish item) {
    Get.toNamed(MainRoutes.details, arguments: {'item': item});
  }
}
