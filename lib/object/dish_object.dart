import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:text/const/const_app_img.dart';

import '../ui/navigations/main_navigation.dart';
part 'dish_object.g.dart';

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

  Dish({
    required this.name,
    required this.id,
    required this.price,
    required this.imgUrl,
    required this.description,
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

  List<Dish> get items => _items.toList();
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
    //   name: 'Lorem ipsum dolor  ipsum 5',
    //   price: 37.0,
    //   isHot: false,
    //   imgUrl: ConstAppImgURL.imgURL2,
    //   description: 'Lorem dolor ipsum dolor ipsum dolor ipsum',
    // );
    // box.add(q1);
    // box.clear();
    _items = box.values.toList();
    //_items = [];
    _loadDataFavoritAndHotPromo(box);
    notifyListeners();
  }

  void _loadDataFavoritAndHotPromo(Box<Dish> box) {
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
