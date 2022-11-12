import 'package:hive_flutter/hive_flutter.dart';
import 'package:text/app/theme/theme_app.dart';
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

  static List<Dish> dish = [
    Dish(
      name: 'name',
      id: 'qw',
      price: 100,
      imgUrl: ThemeAppImgURL.imgURL1,
      description: 'description',
      category: DishCategory.mainCourse,
    ),
    Dish(
      name: 'name1',
      id: 'qw2',
      price: 100,
      imgUrl: ThemeAppImgURL.imgURL1,
      description: 'description',
      category: DishCategory.mainCourse,
    ),
    Dish(
      name: 'name2',
      id: 'qw3',
      price: 100,
      imgUrl: ThemeAppImgURL.imgURL1,
      description: 'description',
      category: DishCategory.mainCourse,
    )
  ];
}
