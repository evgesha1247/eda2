import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:text/utils/app_constants.dart';

import '../../models/cart_model.dart';

class CartRepo {
  final SharedPreferences sharedStore;
  CartRepo({required this.sharedStore});

  List<String> _cart = [];

  List<CartModel> getCartList() {
    print('object 1');
    if (sharedStore.containsKey(AppConstansts.CART_LIST)) {
      List<CartModel> cartList = [];
      sharedStore.getStringList(AppConstansts.CART_LIST)!.forEach(
            (element) => cartList.add(CartModel.fromJson(jsonDecode(element))),
          );

      return cartList;
    }
    return [];
  }

  void addToCartList(List<CartModel> cartList) {
    print('object 2');
    _cart = [];
    cartList.forEach((element) => _cart.add(jsonEncode(element)));
    sharedStore.setStringList(AppConstansts.CART_LIST, _cart);
    getCartList();
  }
}
