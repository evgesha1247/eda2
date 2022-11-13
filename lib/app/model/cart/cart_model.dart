import 'package:get/get.dart';
import 'package:text/app/data/object/dish_object.dart';
class CartModel extends GetxController {

  final _delivery = 5.0;
  double get delivery => _delivery;
  promotions() {
    if (total > 3000) {
      return 0 - total / 100 * 15;
    } else if (total > 1000) {
      return 0;
    } else if (total > 0) {
      return delivery;
    } else {
      return 0.0;
    }
  }


  double get total {
    var total = 0.0;
    _cart.forEach(
      (key, item) {
        total += item.price * item.number;
      },
    );
    return total;
  }



  final _cart = {}.obs;
  get cart => _cart;

  get cartSubTotal => _cart.entries
      .map((product) => product.key.price * product.value)
      .toList();


  get cartTotal => _cart.entries
      .map((product) => product.key.price * product.value)
      .toList()
      .reduce((value, element) => value + element)
      .toStringAsFixed(2);

  void addProduct(Dish product) {
    if (_cart.containsKey(product)) {
      _cart[product] += 1;
    } else {
      _cart[product] = 1;
      Get.snackbar(
        'Dish added',
        'You have added the ${product.name} to cart',
        duration: const Duration(milliseconds: 700),
      );
    }
  }

  void addAndClearOneProduct(Dish product) {
    if (_cart.containsKey(product)) {
      _cart.removeWhere((key, value) => key == product);
    } else if (!_cart.containsKey(product)) {
      _cart[product] = 1;
    }



  }



  void removeProduct(Dish product) {
    (_cart.containsKey(product) && _cart[product] == 1)
        ? _cart.removeWhere((key, value) => key == product)
        : _cart.containsKey(product)
            ? _cart[product] -= 1
            : null;
  }


}
