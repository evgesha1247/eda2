import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../ui/navigations/main_navigation.dart';

part 'dish_object.g.dart';

abstract class Category {
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
  bool isFovarit;
  @HiveField(7)
  String id;
  @HiveField(8)
  String category;

  Dish({
    required this.name,
    required this.id,
    required this.price,
    required this.imgUrl,
    required this.description,
    required this.category,
    this.isHot = false,
    this.isFovarit = false,
  });
}

class DishModel extends ChangeNotifier {
  DishModel() {
    _setup();
  }
  var _items = <Dish>[];
  final _itemsFovarit = <Dish>[];
  final _itemsHotDish = <Dish>[];

  final _itemsDrinkables = <Dish>[];
  final _itemsMainCourse = <Dish>[];
  final _itemsDessert = <Dish>[];

  List<Dish> get items => _items.toList();

  List<Dish> get itemsDrinkables => itemsDrinkables.toList();
  List<Dish> get itemsMainCourse => itemsMainCourse.toList();
  List<Dish> get itemsDessert => itemsDessert.toList();

  List<Dish> get itemsHotDish => _itemsHotDish.toList();
  List<Dish> get itemsFovarit => _itemsFovarit.toList();


  void showDetail(BuildContext context, int index) async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(DishAdapter());
    }
    final box = await Hive.openBox<Dish>('dish_box');
    final dishKey = box.keyAt(index);
    // ignore: use_build_context_synchronously
    await Navigator.of(context)
        .pushNamed(MainNavigationRouteName.details, arguments: dishKey);
  }

  void _readBoxDishsFromHive(Box<Dish> box) {
    // final q1 = Dish(
    //   id: '${DateTime.now()}',
    //   name: 'drinkables 1',
    //   price: 100.0,
    //   isHot: true,
    //   imgUrl: ConstAppImgURL.imgURLPromo2,
    //   category: Category.drinkables,
    //   description: 'Lorem dolor ipsum dolor ipsum dolor ipsum',
    // );
    // box.add(q1);
    // box.clear();
    // box.deleteFromDisk();
    _items = box.values.toList();
    //_items = [];
    _loadData(box);
    notifyListeners();
  }

  void _loadData(Box<Dish> box) {
    // set Fovarit
    for (var element in box.values) {
      if (element.isFovarit) {
        if (_itemsFovarit.contains(element)) continue;
        _itemsFovarit.add(element);
      }
      if (!element.isFovarit) {
        _itemsFovarit.remove(element);
      }
    }

    ///set hot

    for (var element in items) {
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

    // set Drinkables

    for (var element in _items) {
      if (_itemsDrinkables.contains(element)) continue;
      if (element.category == Category.drinkables) {
        _itemsDrinkables.add(element);
      } else {
        _itemsDrinkables.remove(element);
      }
    }

    // set MainCourse

    for (var element in _items) {
      if (_itemsMainCourse.contains(element)) continue;
      if (element.category == Category.mainCourse) {
        _itemsMainCourse.add(element);
      } else {
        _itemsMainCourse.remove(element);
      }
    }

    //set Dessert
    for (var element in _items) {
      if (_itemsDessert.contains(element)) continue;
      if (element.category == Category.dessert) {
        _itemsDessert.add(element);
      } else {
        _itemsDessert.remove(element);
      }
    }


    notifyListeners();
  }

  void _setup() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(DishAdapter());
    }
    final box = await Hive.openBox<Dish>('dish_box');
    _readBoxDishsFromHive(box);

    box.listenable().addListener(() {
      _readBoxDishsFromHive(box);
    });
  }

  void toggFovarit(index) async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(DishAdapter());
    }
    final box = await Hive.openBox<Dish>('dish_box');
    box.values.toList()[index].isFovarit =
        !box.values.toList()[index].isFovarit;
    box.values.toList()[index].save();
    notifyListeners();
  }
}
