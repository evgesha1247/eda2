import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:text/app/routes/main_screens.dart';
import '../../theme/theme_app.dart';
import '../box_menager/box_menager.dart';
part 'dish_object.g.dart';

abstract class DishCategory {
  static const String drinkables = 'drinkables';
  static const String mainCourse = 'mainCourse';
  static const String dessert = 'dessert';
}

@HiveType(typeId: 0)
class Dish extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String description;
  @HiveField(2)
  bool isHot;
  @HiveField(4)
  double price;
  // @HiveField(3)
  @HiveField(5)
  String imgUrl;
  @HiveField(6)
  bool isFavorit;
  @HiveField(7)
  String id;
  //@HiveField(8)
  @HiveField(9)
  String category;

  Dish({
    required this.name,
    required this.id,
    required this.price,
    required this.imgUrl,
    required this.description,
    required this.category,
    this.isHot = false,
    this.isFavorit = false,
  });
}

class DishModel extends ChangeNotifier {
  late final Future<Box<Dish>> _box;
  DishModel() {
    _setup();
  }

  var _items = <Dish>[];
  List<Dish> get items => _items;
  final _itemsHotDish = <Dish>[];
  List<Dish> get itemsHotDish => _itemsHotDish.toList();
  final _itemsMainCourse = <Dish>[];
  List<Dish> get itemsMainCourse => _itemsMainCourse.toList();

  var _itemsFilter = <Dish>[];
  List<Dish> get itemsFilter => _itemsFilter;

  Future<void> _setup() async {
    _box = BoxManadger.instance.openBoxDish();

    // final dish = Dish(
    //   isHot: true,
    //   name: 'name3',
    //   id: DateTime.now().toString(),
    //   price: 320,
    //   imgUrl: ThemeAppImgURL.imgURLPromo1,
    //   description: 'description',
    //   category: DishCategory.dessert,
    // );

    // (await _box).add(dish);

    await _readDishData();
    (await _box).listenable().addListener(_readDishData);
  }

  Future<void> _readDishData() async {
    _loadHotDish();
    _loadMainCourse();
    _loadAllDish();
    notifyListeners();
  }

  Future<void> _loadAllDish() async {
    _items = (await _box).values.toList();
    _itemsFilter = _items;
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

void showDetail(Dish item) {
    Get.toNamed(MainRoutes.details, arguments: item.key);
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
    item.isFavorit = !item.isFavorit;
    await item.save();
  }

  showCart(context) => Navigator.pushNamed(context, MainRoutes.cart);
}
