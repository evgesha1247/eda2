import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: unused_import'
import '../../../box_menager/box_menager.dart';
import '../../../object/dish_object.dart';
import '../../navigations/main_navigation.dart';

class HomeModel extends ChangeNotifier {
  HomeModel() {
    _setup();
  }
  late final Future<Box<Dish>> _box;

  final _itemsHotDish = <Dish>[];
  List<Dish> get itemsHotDish => _itemsHotDish.toList();

  final _itemsMainCourse = <Dish>[];
  List<Dish> get itemsMainCourse => _itemsMainCourse.toList();
  Future<void> _setup() async {
    _box = BoxManadger.instance.openBoxDish();
    await _readDishData();
    (await _box).listenable().addListener(_readDishData);
  }


  Future<void> _readDishData() async {
    // final dish = Dish(
    //   id: '${DateTime.now()}',
    //   name: 'qwe5',
    //   price: 200.0,
    //   isHot: false,
    //   imgUrl: ThemeAppImgURL.imgURLPromo3,
    //   category: Category.drinkables,
    //   description: 'Lorem dolor ipsum dolor ipsum dolor ipsum',
    // );
    // (await _box).add(dish);
    //await box.clear();
    _loadHotDish();
    _loadMainCourse();
    notifyListeners();
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
    notifyListeners();
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
}
