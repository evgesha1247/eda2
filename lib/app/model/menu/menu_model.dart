import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import '../../data/box_menager/box_menager.dart';
import '../../data/object/dish_object.dart';
import '../../routes/main_screens.dart';

class MenuModel extends GetxController {
  late final Future<Box<Dish>> _box;
  var _items = <Dish>[];
  var _itemsFilter = <Dish>[];
  var cartNumber = 0.obs;
  List<Dish> get items => _items;
  List<Dish> get itemsFilter => _itemsFilter.obs;

  @override
  onInit() {
    _setup();

    super.onInit();
  }




  Future<void> _setup() async {
    _box = BoxManadger.instance.openBoxDish();
    await _loadAllDish();
    (await _box).listenable().addListener(_loadAllDish);
  }

  Future<void> _loadAllDish() async {
    _items = (await _box).values.toList();
    _itemsFilter = _items;
    //cartNumber = _cartModel.numberItem;

    update();
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

  void searchFilter(String text) {
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
    Get.toNamed(MainRoutes.details, arguments: {'item': item});
  }
}
