import 'package:hive/hive.dart';
part 'dish_object.g.dart';

@HiveType(typeId: 0)
class Dish extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String description;
  @HiveField(5)
  String imgUrl;
  @HiveField(4)
  double price;
  @HiveField(2)
  bool isHot;
  // @HiveField(3)

  Dish({
    required this.name,
    required this.price,
    required this.imgUrl,
    required this.isHot,
    required this.description,
  });
}
