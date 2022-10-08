import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../const/const_app_img.dart';
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

  List<Dish> get itemsDrinkables => _itemsDrinkables.toList();
  List<Dish> get itemsMainCourse => _itemsMainCourse.toList();
  List<Dish> get itemsDessert => _itemsDessert.toList();

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
    final q1 = Dish(
      id: '${DateTime.now()}',
      name: 'dfot ghj,ysq  3',
      price: 100.0,
      isHot: true,
      imgUrl: ConstAppImgURL.imgURLPromo3,
      category: Category.mainCourse,
      description: 'Lorem dolor ipsum dolor ipsum dolor ipsum',
    );
    box.add(q1);
    // box.clear();
    //box.deleteFromDisk();
    _items = box.values.toList();
    //_items = [];
    _loadData(box);
    notifyListeners();
  }

  // // set Drinkables
  // for (var element in box.values) {
  //   if (element.category == Category.drinkables &&
  //       !_itemsDrinkables.contains(element)) {
  //     _itemsDrinkables.add(element);
  //   }
  //   if (element.category != Category.drinkables) {
  //     _itemsDrinkables.remove(element);
  //   }
  // }

  // // set MainCourse

  // for (var element in box.values) {
  //   if (element.category == Category.mainCourse &&
  //       !_itemsMainCourse.contains(element)) {
  //     _itemsMainCourse.add(element);
  //   }
  //   if (element.category != Category.mainCourse) {
  //     _itemsMainCourse.remove(element);
  //   }
  // }

  // //set Dessert
  // for (var element in box.values) {
  //   if (element.category == Category.dessert &&
  //       !_itemsDessert.contains(element)) {
  //     _itemsDessert.add(element);
  //   }
  //   if (element.category != Category.dessert) {
  //     _itemsDessert.remove(element);
  //   }
  // }

  void _loadData(Box<Dish> box) {
    // to Fovarit
    for (var element in box.values) {
      if (element.isFovarit) {
        if (_itemsFovarit.contains(element)) continue;
        _itemsFovarit.add(element);
      }
      if (!element.isFovarit) {
        _itemsFovarit.remove(element);
      }
    }

    ///to hot
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
