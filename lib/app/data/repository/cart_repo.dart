import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:text/utils/app_constants.dart';
import '../../models/cart_model.dart';

class CartRepo {
  final SharedPreferences sharedStore;
  CartRepo({required this.sharedStore});

  List<String> _cart = [];
  List<String> _cartHistory = [];

  void addToLocalCartList(List<CartModel> cartList) {
    // sharedStore.remove(AppConstansts.CART_LIST);
    // sharedStore.remove(AppConstansts.CART_HISTORY_LIST);
    // return;
    _cart = [];
    var time = DateTime.now().toString();
    cartList.forEach((element) {
      element.time = time;
      return _cart.add(jsonEncode(element));
    });

    sharedStore.setStringList(AppConstansts.CART_LIST, _cart);

  }

  List<CartModel> getCartListFromLocal() {
    List<String> carts = [];
    if (sharedStore.containsKey(AppConstansts.CART_LIST)) {
      carts = sharedStore.getStringList(AppConstansts.CART_LIST)!;
    }
    List<CartModel> cartList = [];
    carts.forEach(
        (element) => cartList.add(CartModel.fromJson(jsonDecode(element))));
    return cartList;
  }

  //// histori
  void addToLocalCartHistoryList() {
    if (sharedStore.containsKey(AppConstansts.CART_HISTORY_LIST)) {
      _cartHistory =
          sharedStore.getStringList(AppConstansts.CART_HISTORY_LIST)!;
    }

    for (var i = 0; i < _cart.length; i++) {
      _cartHistory.add(_cart[i]);
    }
    removeCart();
    sharedStore.setStringList(AppConstansts.CART_HISTORY_LIST, _cartHistory);
    // print(
    //     '  count -------- ' + getCartHistoryListFromLocal().length.toString());
    // for (var j = 0; j < getCartHistoryListFromLocal().length; j++) {
    //   print(getCartHistoryListFromLocal()[j].time.toString());
    //   print('|');
    // }
  }

void removeCart() {
    _cart = [];
    sharedStore.remove(AppConstansts.CART_LIST);
  }

  List<CartModel> getCartHistoryListFromLocal() {
    if (sharedStore.containsKey(AppConstansts.CART_HISTORY_LIST)) {
      _cartHistory =
          sharedStore.getStringList(AppConstansts.CART_HISTORY_LIST)!;
    }
    List<CartModel> cartListHistory = [];

    _cartHistory.forEach((element) =>
        cartListHistory.add(CartModel.fromJson(jsonDecode(element))));

    return cartListHistory;
  }
}
