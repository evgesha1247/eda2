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



/// обновление элементов корзина на -1 или 1
void addItem(ProductModel product, int count) {
    var totalCount = 0;
    if (_items.containsKey(product.id)) {
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
    update();
  }

///тупейшая проверка на присудствие элемента в корзине
bool existInCart(ProductModel product) {
    if (_items.containsKey(product.id)) {
      return true;
    } else {
      return false;
    }
  }

/// количество одного элемента в корзине
int getCountProduct(ProductModel product) {
    var count = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach(
        (key, value) {
          if (key == product.id) {
            count = value.count!;
          }
        },
      );
    }
    return count;
  }

/// всего элементов в корзине
int get totalItems {
    var totalCount = 0;
    _items.forEach((key, value) {
      totalCount += value.count!;
    });
    return totalCount;
  }

/// общая цена в корзине
int discount = 15;

  double totalAndDiscount = 0;
  double total = 0;

  double get totalAmount {
    total = 0;
    _items.forEach((key, value) {
      total += (value.price! * value.count!);
    });
    totalAndDiscount = total - (total / 100 * discount);
    return total > 200 ? totalAndDiscount : total;
  }


/// удаляет из корзины
void delite(ProductModel product) {
    _items.remove(product.id);
    Get.find<ProductController>()
        .initCount(product, Get.find<CartController>());
    update();
  }
// clear
  void clearCart() {
    _items.clear();
    Get.snackbar(
      'pay',
      '',
      backgroundColor: ThemeAppColor.kAccent.withOpacity(0.7),
      colorText: ThemeAppColor.kBGColor,
      duration: const Duration(milliseconds: 1200),
      margin: EdgeInsets.all(ThemeAppSize.kInterval12),
    );
    update();
  }

}
