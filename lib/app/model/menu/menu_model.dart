import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import '../../data/box_menager/box_menager.dart';
import '../../data/object/dish_object.dart';
import '../../routes/main_screens.dart';

class MenuModel extends GetxController {
  late final Future<Box<Dish>> _box;
  var _items = <Dish>[];
  List<Dish> get items => _items;
  var _itemsFilter = <Dish>[];
  List<Dish> get itemsFilter => _itemsFilter;

@override
  void onReady() {
    print('readby');
    super.onReady();
  }

  @override
  onInit() {
    _setup();
    print('init');
    super.onInit();
  }

  Future<void> _setup() async {
    _box = BoxManadger.instance.openBoxDish();

    await _readDishData();
    (await _box).listenable().addListener(_readDishData);
  }

  Future<void> _readDishData() async {
    _loadAllDish();
    update();
  }

  Future<void> _loadAllDish() async {
    _items = (await _box).values.toList();
    _itemsFilter = _items;
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
    update();
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
    update();
  }

  Future<void> toggFovarit(Dish item) async {
    item.isFavorit = !item.isFavorit;
    await item.save();
  }
  void showDetail(Dish item) {
    Get.toNamed(MainRoutes.details, arguments: item.key);
  }
}
