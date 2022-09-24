import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
  List<Dish> get items => _items.toList();
  void _readBoxDishsFromHive(Box<Dish> box) {
    // final a1 = Dish(
    //     id: 'q2',
    //     name: 'имя',
    //     price: 89.4,
    //     imgUrl: 'assets/imgs/food2.png',
    //     description:
    //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu');
    _items = box.values.toList();
    notifyListeners();
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
}
