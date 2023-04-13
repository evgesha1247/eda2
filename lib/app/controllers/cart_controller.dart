import 'package:get/get.dart';
import 'package:text/app/controllers/product_controller.dart';
import 'package:text/app/models/products_model.dart';
import '../data/repository/cart_repo.dart';
import '../models/cart_model.dart';
import '../theme/theme_app.dart';
import 'auth_controller.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};
  List<CartModel> get getItemsList =>
      _items.entries.map((e) => e.value).toList();

void buy() {
    final data = Get.find<AuthController>().userData;
    if (data['adress'] == null ||
        data['adress'] == '' ||
        data['phone'] == null ||
        data['phone'] == '') {
      Get.snackbar('адрес или телефон', ' вы не указали данные или они не верны !');
    } else {
    cartRepo.addToLocalCartList(getItemsList);
    cartRepo.addToLocalCartHistoryList();
    cartRepo.pushCartGlobal(getItemsList);
    _clearCart();
    }
  }

  void _clearCart() {
    _items = {};

    ThemeAppFun.printSnackBar('Thank you for your purchase',
        title: 'Payment sucess');
    update();
  }

  //// LOCAL ///////////////////////////
  List<CartModel> _itemCartFromLocal = [];
  List<CartModel> getCartListLocal() {
    _setCartLocal = cartRepo.getCartListFromLocal();
    return _itemCartFromLocal;
  }

  set _setCartLocal(List<CartModel> items) {
    _itemCartFromLocal = items;
    for (var i = 0; i < _itemCartFromLocal.length; i++) {
      _items.putIfAbsent(
          _itemCartFromLocal[i].product!.id!, () => _itemCartFromLocal[i]);
    }
  }
  List<CartModel> getHistoryList() {
    return cartRepo.getCartHistoryListFromLocal();
  }

///////////////////////////////////////////////




  /// общая цена в корзине
  int discount = 15;
  double get totalAmount {
    double total = 0;
    _items.forEach((key, value) {
      total += (value.product!.price! * value.count!);
    });
    return total > 200 ? (total - (total / 100 * discount)) : total;


  }


  int totalPrice() {
    var total = 0;
    var history = getHistoryList().toList();
    for (int i = 0; i < history.length; i++) {
      total += history[i].count! * history[i].product!.price!;
    }
    return total;
  }

  /// обновление элементов корзина на -1 или 1
  void addItem(ProductModel product, int count) {
    if (existInCart(product)) {
      var totalCount = 0;
      _items.update(product.id!, (value) {
        totalCount = value.count! + count;
        return CartModel(
          id: value.id,
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
    cartRepo.addToLocalCartList(getItemsList);
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
          count: 1,
          time: DateTime.now().toString(),
          isExit: true,
          product: product,
        ),
      );
    }
    cartRepo.addToLocalCartList(getItemsList);
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




  void delite(ProductModel product) {
    _items.remove(product.id);
    Get.find<ProductController>()
        .initCountToCart(product, Get.find<CartController>());
    cartRepo.addToLocalCartList(getItemsList);
    update();
  }

}
