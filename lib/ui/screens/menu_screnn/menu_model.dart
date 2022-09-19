import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../../object/dish_object.dart';
import '../../navigations/main_navigation.dart';

class MenuModel extends ChangeNotifier {
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
}
