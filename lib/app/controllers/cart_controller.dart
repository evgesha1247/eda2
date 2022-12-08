import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/controllers/product_controller.dart';
import 'package:text/app/models/products_model.dart';
import '../data/repository/cart_repo.dart';
import '../models/cart_model.dart';
import '../theme/theme_app.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});

  final Map<int, CartModel> _items = {};
  List<CartModel> get getItemsList =>
      _items.entries.map((e) => e.value).toList();

  //// LOCAL
  List<CartModel> _itemsLocal = [];
  List<CartModel> getItemsListLocal() {
    setCartLocal = cartRepo.getCartList();
    return _itemsLocal;
  }

  set setCartLocal(List<CartModel> items) {
    _itemsLocal = items;
    for (var i = 0; i < _itemsLocal.length; i++) {
      _items.putIfAbsent(_itemsLocal[i].product!.id!, () => _itemsLocal[i]);
    }
    update();
  }

  ///

  /// общая цена в корзине
  int discount = 15;
  double get totalAmount {
    double total = 0;
    _items.forEach((key, value) {
      total += (value.price! * value.count!);
    });
    return total > 200 ? (total - (total / 100 * discount)) : total;
  }
  /// обновление элементов корзина на -1 или 1
  void addItem(ProductModel product, int count) {
    if (existInCart(product)) {
      var totalCount = 0;
      _items.update(product.id!, (value) {
        totalCount = value.count! + count;
        return CartModel(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          count: value.count! + count,
          time: DateTime.now().toString(),
          isExit: true,
          product: product,
        );
      });

      if (totalCount <= 0) {
        _items.remove(product.id);
      }

    } else if (count > 0) {
      _items.putIfAbsent(
        product.id!,
        () {
          return CartModel(
            id: product.id,
            name: product.name,
            price: product.price,
            img: product.img,
            count: count,
            time: DateTime.now().toString(),
            isExit: true,
            product: product,
          );
        },
      );
    } else {
      ThemeAppFun.printSnackBar('You can\'t add zero to carts !');
    }
    cartRepo.addToCartList(getItemsList);
    update();
  }
  /// добавить 1 либо удалить
  void addOneInCart(ProductModel product) {
    if (existInCart(product)) {
      _items.remove(product.id);
    } else {
      _items.putIfAbsent(
        product.id!,
        () => CartModel(
          id: product.id,
          name: product.name,
          price: product.price,
          img: product.img,
          count: 1,
          time: DateTime.now().toString(),
          isExit: true,
          product: product,
        ),
      );
    }
    cartRepo.addToCartList(getItemsList);
    update();
  }
  /// проверка на наличие элемента в корзине по id
  bool existInCart(ProductModel product) => (_items.containsKey(product.id));
  /// количество одного элемента в корзине
  int getCountProduct(ProductModel product) {
    return existInCart(product)
        ? _items.values.firstWhere((element) => element.id == product.id).count!
        : 0;
  }
  /// всего элементов в корзине
  int get totalItems {
    var totalCount = 0;
    _items.forEach((key, value) {
      totalCount += value.count!;
    });
    return totalCount;
  }
  /// удаляет из корзины
  void delite(ProductModel product) {
    _items.remove(product.id);
    Get.find<ProductController>()
        .initCountToCart(product, Get.find<CartController>());
    update();
  }
  /// clear
  void clearCart() {
    _items.clear();
    Get.snackbar(
      'pay',
      '',
      backgroundColor: Get.context?.theme.primaryColor.withOpacity(0.7),
      colorText: Get.context?.theme.cardColor,
      duration: const Duration(milliseconds: 1200),
      margin: EdgeInsets.all(ThemeAppSize.kInterval12),
    );
    cartRepo.addToCartList(getItemsList);
    update();
  }


}
