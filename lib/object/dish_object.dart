import 'package:hive/hive.dart';
part 'dish_object.g.dart';

@HiveType(typeId: 0)
class Dish extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String description;
  @HiveField(2)
  bool isHot = false;
  @HiveField(4)
  double price;
  // @HiveField(3)
  @HiveField(5)
  String imgUrl;
  @HiveField(6)
  bool isFovarit = false;

  Dish({
    required this.name,
    required this.price,
    required this.imgUrl,
    required this.description,
    this.isHot = false,
    this.isFovarit = false,
  });
}
