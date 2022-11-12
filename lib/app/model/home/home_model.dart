import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import '../../data/box_menager/box_menager.dart';
import '../../data/object/dish_object.dart';
import '../../routes/main_screens.dart';

class HomeModel extends GetxController {
  User? user;
  late final Future<Box<Dish>> _box;
  final _itemsHotDish = <Dish>[];
  final _itemsMainCourse = <Dish>[];
  List<Dish> get itemsHotDish => _itemsHotDish.toList();
  List<Dish> get itemsMainCourse => _itemsMainCourse.toList();

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
      print('user is null !!!');
    }
    await _readDishData();
    (await _box).listenable().addListener(_readDishData);
  }

  List<bool> selected = List.generate(4, (i) => false).obs;



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
      } else if (!element.isHot && _itemsHotDish.contains(element)) {
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
      if (element.category != DishCategory.mainCourse &&
          _itemsMainCourse.contains(element)) {
        _itemsMainCourse.remove(element);
      }
    }
    update();
  }
  void showDetail(Dish item) {
    Get.toNamed(MainRoutes.details, arguments: {'item': item});
  }

}
