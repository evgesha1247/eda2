import 'dart:collection';
import 'package:flutter/material.dart';

class Cart {
  final String id;
  final int number;
  final String name;
  final double price;
  final String imgUrl;

  Cart({
    required this.id,
    required this.number,
    required this.name,
    required this.price,
    required this.imgUrl,
  });
}

class CartModel extends ChangeNotifier {

  Map<String, Cart> _cartItem = {};
  UnmodifiableMapView<String, Cart> get cartItem =>
      UnmodifiableMapView(_cartItem);
  final _delivery = 5.0;

  double get delivery => _delivery;
  promotions() {
    if (total > 3000) {
      return 0 - total / 100 * 15;
    } else if (total > 1000) {
      return 0;
    } else if (total > 0) {
      return delivery;
    }
    return 0;
  }

  int namber(String dishKey) {
    var number = 0;
    _cartItem.forEach(
      (key, item) {
        if (key == dishKey) {
          number = item.number;
        }
      },
    );
    return number;
  }

  int number() {
    var number = 0;
    cartItem.forEach(
      (key, item) {
        number += item.number;
      },
    );
    return number;
  }

  double get total {
    var total = 0.0;
    _cartItem.forEach(
      (key, item) {
        total += item.price * item.number;
      },
    );
    return total;
  }

  double subTotal(String dishKey) {
    var subTotal = 0.0;
    _cartItem.forEach(
      (key, item) {
        if (key == dishKey) {
          subTotal += item.price * item.number;
        }
      },
    );
    return subTotal;
  }

  void addItem({dishId, price, name, imgUrl}) {
    if (_cartItem.containsKey(dishId)) {
      _cartItem.update(
        dishId,
        (item) => Cart(
          id: item.id,
          number: item.number + 1,
          name: item.name,
          price: item.price,
          imgUrl: item.imgUrl,
        ),
      );
    } else {
      _cartItem.putIfAbsent(
        dishId,
        () => Cart(
          id: '${DateTime.now()}',
          number: 1,
          name: name,
          price: price,
          imgUrl: imgUrl,
        ),
      );
    }
    notifyListeners();
  }

  void delete(dishId) {
    _cartItem.remove(dishId);
    notifyListeners();
  }

  void updataAddOne(dishId) {
    _cartItem.update(
      dishId,
      (item) => Cart(
        id: item.id,
        number: item.number + 1,
        name: item.name,
        price: item.price,
        imgUrl: item.imgUrl,
      ),
    );
    notifyListeners();
  }

  void updataSubOne(dishId) {
    if ((_cartItem[dishId]?.number ?? 0) < 2) {
      delete(dishId);
    } else {
      _cartItem.update(
        dishId,
        (item) => Cart(
          id: item.id,
          number: item.number - 1,
          name: item.name,
          price: item.price,
          imgUrl: item.imgUrl,
        ),
      );
    }

    notifyListeners();
  }

  void clear() {
    _cartItem = {};
    notifyListeners();
  }

  void showMenu(context) {
    Navigator.of(context).pop();
  }
}
