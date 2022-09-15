import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:text/object/dish_model.dart';

import '../../../object/dish_object.dart';

class MenuModel extends DishModel {
  void showDetail(BuildContext context, int index) async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(DishAdapter());
    }
    final box = await Hive.openBox<Dish>('dish_box');
    final key = box.keyAt(index);
    await Navigator.of(context).pushNamed('/guiding/details', arguments: key);
  }
}
