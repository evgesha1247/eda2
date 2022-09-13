import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'dish_object.g.dart';

@HiveType(typeId: 0)
class Dish with ChangeNotifier {
  @HiveField(0)
  String name;
  @HiveField(1)
  String imgUrl;
  @HiveField(2)
  bool isHot;
  @HiveField(3)
  String id;
  @HiveField(4)
  double price;
  @HiveField(5)
  String description;

  Dish({
    required this.name,
    required this.price,
    required this.id,
    required this.imgUrl,
    required this.isHot,
    required this.description,
  });
}

class DishDataPovider with ChangeNotifier {
  final List<Dish> _dishs = [
    Dish(
      id: '0',
      name: 'name1',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
      imgUrl: 'assets/imgs/food1.png',
      isHot: true,
      price: 97.9,
    ),
    Dish(
      id: '1',
      price: 96.4,
      name: 'name2',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
      imgUrl: 'assets/imgs/food5.png',
      isHot: false,
    ),
    Dish(
      id: '2',
      name: 'name3',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
      price: 93,
      imgUrl: 'assets/imgs/food3.png',
      isHot: false,
    ),
  ];
  UnmodifiableListView<Dish> get dishs => UnmodifiableListView(_dishs);
  Dish getById(String id) => _dishs.singleWhere((element) => element.id == id);
}
