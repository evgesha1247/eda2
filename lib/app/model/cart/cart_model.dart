import 'dart:collection';
import 'package:get/get.dart';
import 'package:text/app/model/dish_detailed/dish_detailed_model.dart';
import '../../data/object/cart_object.dart';

class CartModel extends GetxController {
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


  numberDish(String? dishKey) {
    var numberItem = 0;
    _cartItem.forEach(
      (key, item) {
        if (key == dishKey) {
          numberItem = item.number;
        }
      },
    );
    update();
    return numberItem;
  }

  subTotal(String? dishKey) {
    var subTotalItem = 0.0;
    _cartItem.forEach(
      (key, item) {
        if (key == dishKey) {
          subTotalItem += item.price * item.number;
        }
      },
    );
    update();
    return subTotalItem;

  }

  var numberItems = 0;
  void numberDishs() {
    _cartItem.forEach(
      (key, item) {
        numberItems += item.number;
      },
    );
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
    update();
  }

  void delete(dishId) {
    _cartItem.remove(dishId);
    update();
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
    update();
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
    update();
  }

  void clear() {
    _cartItem = {};
    update();
  }


  void showBack() {
    Get.put(DishDetailedModel()).upDataDitalit();
    Get.back();
  }
}
