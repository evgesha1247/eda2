import 'package:flutter/cupertino.dart';


class BoxManadger extends ChangeNotifier {
  // static final BoxManadger instance = BoxManadger._();
  // BoxManadger._();

  // final Map<String, int> _boxCount = <String, int>{};
  // Future<Box<T>> _openBox<T>(
  //   String name,
  //   int typeId,
  //   TypeAdapter<T> adapter,
  // ) async {
  //   if (Hive.isBoxOpen(name)) {
  //     final count = _boxCount[name] ?? 1;
  //     _boxCount[name] = count + 1;
  //     return Hive.box(name);
  //   }
  //   _boxCount[name] = 1;
  //   if (!Hive.isAdapterRegistered(typeId)) {
  //     Hive.registerAdapter(adapter);
  //   }
  //   return await Hive.openBox<T>(name);
  // }

  // Future<void> clousBox<T>(Box<T> box) async {
  //   if (!box.isOpen) {
  //     _boxCount.remove(box.name);
  //     return;
  //   }
  //   final count = _boxCount[box.name] ?? 1;
  //   _boxCount[box.name] = count - 1;
  //   if (count > 0) return;
  //   _boxCount.remove(box.name);
  //   await box.compact();
  //   await box.close();
  // }

  // Future<Box<Dish>> openBoxDish() async {
  //   return _openBox('dish_box', 0, DishAdapter());
  // }

}
