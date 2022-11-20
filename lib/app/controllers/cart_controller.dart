import 'package:get/get.dart';
import 'package:text/app/models/products_model.dart';
import '../data/repository/cart_repo.dart';
import '../models/cart_model.dart';
import '../theme/theme_app.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});

  final Map<int, CartModel> _items = {};
  List<CartModel> get getCartItems {
    return _items.entries.map((e) => e.value).toList();
  }


  Map<int, CartModel> get items => _items;

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
        items.remove(product.id);
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

  bool existInCart(ProductModel product) {
    if (_items.containsKey(product.id)) {
      return true;
    } else {
      return false;
    }
  }

  int getCount(ProductModel product) {
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

  int get totalItems {
    var totalCount = 0;
    _items.forEach((key, value) {
      totalCount += value.count!;
    });

    return totalCount;
  }


}
