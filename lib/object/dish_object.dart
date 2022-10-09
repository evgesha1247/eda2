import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
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

class DishModel extends ChangeNotifier {}

  // final _itemsFovarit = <Dish>[];
  // final _itemsHotDish = <Dish>[];

  // final _itemsDrinkables = <Dish>[];
  // final _itemsMainCourse = <Dish>[];
  // final _itemsDessert = <Dish>[];



  // List<Dish> get itemsDrinkables => _itemsDrinkables.toList();
  // List<Dish> get itemsMainCourse => _itemsMainCourse.toList();
  // List<Dish> get itemsDessert => _itemsDessert.toList();

  // List<Dish> get itemsHotDish => _itemsHotDish.toList();
  // List<Dish> get itemsFovarit => _itemsFovarit.toList();




  // void _loadData(Box<Dish> box) {
  //   for (var element in _items) {
  //     if (element.isFavorit) {
  //       if (_itemsFovarit.contains(element)) continue;
  //       _itemsFovarit.add(element);
  //     }
  //     if (element.isHot) {
  //       if (!_itemsHotDish.contains(element)) continue;
  //       if (_itemsHotDish.length >= 3) {
  //         _itemsHotDish.remove(_itemsHotDish.first);
  //         _itemsHotDish.add(element);
  //       } else {
  //         _itemsHotDish.add(element);
  //       }
  //     }
  //     if (!element.isFavorit) {
  //       _itemsFovarit.remove(element);
  //     }
  //     if (!element.isHot) {
  //       _itemsHotDish.remove(element);
  //     }
  //   }

  //   notifyListeners();
  // }

//   void toggFovarit(index) async {
    // final current = _items[index].isFavorit;
    // _items[index].isFavorit = !current;
    // await _items[index].save();
    // notifyListeners();
//   }
// }


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
