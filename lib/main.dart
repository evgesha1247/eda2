import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:text/ui/widgets/app/my_app_widget.dart';
import 'object/dish_object.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(DishAdapter());
  await Hive.openBox<Dish>('dish_box');
  runApp(const MyAppWidget());
}
