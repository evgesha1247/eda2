import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:text/utils/app_constants.dart';

import '../../models/cart_model.dart';

class CartRepo {
  final SharedPreferences sharedStore;
  CartRepo({required this.sharedStore});

  List<String> _cart = [];
  List<String> _cartHistory = [];


  void addToCartList(List<CartModel> cartList) {
    // sharedStore.remove(AppConstansts.CART_LIST);
    // sharedStore.remove(AppConstansts.CART_HISTORY_LIST);
    // return;
    var time = DateTime.now().toString();
    _cart = [];

    for (var element in cartList) {
      element.time = time;
      _cart.add(jsonEncode(element));
    }

    sharedStore.setStringList(AppConstansts.CART_LIST, _cart);
    //  sharedStore.remove(AppConstansts.CART_LIST);
    getCartList();
  }

  List<CartModel> getCartList() {
    List<String> carts = [];
    if (sharedStore.containsKey(AppConstansts.CART_LIST)) {
      carts = sharedStore.getStringList(AppConstansts.CART_LIST)!;
    }
    List<CartModel> cartList = [];
    for (var element in carts) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    }

    return cartList;
  }


  List<CartModel> getCartHistoryList() {

    if (sharedStore.containsKey(AppConstansts.CART_HISTORY_LIST)) {

      _cartHistory =
          sharedStore.getStringList(AppConstansts.CART_HISTORY_LIST)!;
    }
    List<CartModel> cartListHistory = [];
    for (var element in _cartHistory) {
      cartListHistory.add(CartModel.fromJson(jsonDecode(element)));
    }

    return cartListHistory;
  }

  void addToCartHistoryList() {
    if (sharedStore.containsKey(AppConstansts.CART_HISTORY_LIST)) {
      _cartHistory =
          sharedStore.getStringList(AppConstansts.CART_HISTORY_LIST)!;
    }
    for (var i = 0; i < _cart.length; i++) {
      _cartHistory.add(_cart[i]);
    }
    _cart = [];
    sharedStore.remove(AppConstansts.CART_LIST);
    sharedStore.setStringList(AppConstansts.CART_HISTORY_LIST, _cartHistory);
    print('  count -------- ' + getCartHistoryList().length.toString());
  }
}
