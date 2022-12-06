import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:text/utils/app_constants.dart';

import '../../models/cart_model.dart';

class CartRepo {
  final SharedPreferences sharedStore;
  CartRepo({required this.sharedStore});

  List<String> _cart = [];

  List<CartModel> getCartList() {
    if (sharedStore.containsKey(AppConstansts.CART_LIST)) {
      List<CartModel> cartList = [];
      for (var element in sharedStore.getStringList(AppConstansts.CART_LIST)!) {
        cartList.add(CartModel.fromJson(jsonDecode(element)));
      }

      return cartList;
    }
    return [];
  }

  void addToCartList(List<CartModel> cartList) {
    _cart = [];
    for (var element in cartList) {
      _cart.add(jsonEncode(element));
    }
    sharedStore.setStringList(AppConstansts.CART_LIST, _cart);
    getCartList();
  }
}
