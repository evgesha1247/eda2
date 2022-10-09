import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: unused_import
import '../../../const/const_app_img.dart';
import '../../../object/dish_object.dart';
import '../../navigations/main_navigation.dart';

class HomeModel extends ChangeNotifier {
  HomeModel() {
    _setup();
  }

  final _itemsHotDish = <Dish>[];
  List<Dish> get itemsHotDish => _itemsHotDish.toList();

  final _itemsMainCourse = <Dish>[];
  List<Dish> get itemsMainCourse => _itemsMainCourse.toList();

  void _setup() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(DishAdapter());
    }
    final box = await Hive.openBox<Dish>('dish_box');
    _readDishData(box);

    box.listenable().addListener(() => _readDishData(box));
  }

  void _readDishData(Box<Dish> box) async {
    // final dish = Dish(
    //   id: '${DateTime.now()}',
    //   name: 'qwe2',
    //   price: 100.0,
    //   isHot: true,
    //   imgUrl: ConstAppImgURL.imgURLPromo2,
    //   category: Category.dessert,
    //   description: 'Lorem dolor ipsum dolor ipsum dolor ipsum',
    // );
    // await box.add(dish);
    //await box.clear();
    _loadHotDish(box);
    _loadMainCourse(box);
    notifyListeners();
  }

  void _loadHotDish(Box<Dish> box) {
    for (var element in box.values) {
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

  void _loadMainCourse(Box<Dish> box) {
    for (var element in box.values) {
      if (element.category == Category.mainCourse &&
          !_itemsMainCourse.contains(element)) {
        _itemsMainCourse.add(element);
      }
      if (element.category != Category.mainCourse) {
        _itemsMainCourse.remove(element);
      }
    }
    notifyListeners();
  }

  void showDetail(BuildContext context, Dish item) async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(DishAdapter());
    }
    final box = await Hive.openBox<Dish>('dish_box');

    for (var element in box.values) {
      if (element == item) {

        await Navigator.of(context)
            .pushNamed(MainNavigationRouteName.details, arguments: element.key);
      }
    }

  }
}
