import 'dart:collection';
import 'package:flutter/cupertino.dart';

class DishAdding with ChangeNotifier {
  final String id;
  final String title;
  final double price;
  final int number;
  DishAdding({
    required this.id,
    required this.number,
    required this.price,
    required this.title,
  });
}

class DishAddingDataPovider with ChangeNotifier {
  Map<String, DishAdding> _dishAddingItem = {};
  UnmodifiableMapView<String, DishAdding> get dishAddingItem =>
      UnmodifiableMapView(_dishAddingItem);

  double get allPrice {
    double price = 0.0;
    _dishAddingItem.forEach((key, item) {
      price += item.number * item.price;
    });
    return price;
  }

  void addItem({dishId, price, title, imgUrl}) {
    if (_dishAddingItem.containsKey(dishId)) {
      _dishAddingItem.update(dishId, (dish) {
        return DishAdding(
          id: dish.id,
          number: dish.number + 1,
          price: dish.price,
          title: dish.title,
        );
      });
    } else {
      _dishAddingItem.putIfAbsent(
          dishId,
          () => DishAdding(
                id: '${DateTime.now()}',
                number: 1,
                price: price,
                title: title,
              ));
    }
    notifyListeners();
  }

  void deleteItem(String dishId) {
    _dishAddingItem.remove(dishId);
    notifyListeners();
  }

  void upDataAddOneItem(String dishId) {
    _dishAddingItem.update(
      dishId,
      (value) => DishAdding(
        id: value.id,
        number: value.number + 1,
        price: value.price,
        title: value.title,
      ),
    );
    notifyListeners();
  }

  void upDataSubOneItem(String dishId) {
    if (_dishAddingItem[dishId]!.number < 2) {
      deleteItem(dishId);
    } else {
      _dishAddingItem.update(
        dishId,
        (value) => DishAdding(
          id: value.id,
          number: value.number - 1,
          price: value.price,
          title: value.title,
        ),
      );
    }
    notifyListeners();
  }

  void clear() {
    _dishAddingItem = {};
    notifyListeners();
  }
}
