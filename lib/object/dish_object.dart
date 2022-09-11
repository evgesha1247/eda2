import 'package:hive/hive.dart';

part 'dish_object.g.dart';

@HiveType(typeId: 0)
class Dish {
  @HiveField(0)
  String name;
  Dish(this.name);
}
