import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:text/utils/app_constants.dart';
import '../../controllers/auth_controller.dart';
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
    for (var element in cartList) {
      element.time = time;
      _cart.add(jsonEncode(element));
      continue;
    }
    sharedStore.setStringList(AppConstansts.CART_LIST, _cart);
  }

  List<CartModel> getCartListFromLocal() {
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
  }

  pushCartGlobal(List<CartModel> cartList) {
    final data = Get.find<AuthController>().userData.value;

    final order = [];
    cartList.forEach((element) {
      order.add(
        OrderModel(count: element.count!, name: element.product!.name!)
            .toJson(),
      );
    });

    FirebaseFirestore.instance
        .collection('pay')
        .doc(DateTime.now().toString())
        .set({
      "order": order,
      "user phone": data['phone'],
      "user adress": data['adress'],
    }).onError((e, _) => print("Error writing document: $e"));
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
    for (var element in _cartHistory) {
      cartListHistory.add(CartModel.fromJson(jsonDecode(element)));
    }
    return cartListHistory;
  }
}
