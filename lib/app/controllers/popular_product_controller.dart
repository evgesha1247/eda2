import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/controllers/cart_controller.dart';
import 'package:text/app/models/cart_model.dart';
import 'package:text/app/models/products_model.dart';
import 'package:text/app/theme/theme_app.dart';
import '../data/repository/product_repo.dart';

class PopularProductController extends GetxController {
  final ProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  late CartController _cart;
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;
  List<CartModel> get cartList => _cart.getCartItems;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _countProduct = 0;
  int _inCartItems = 0;

  int get countProduct => _countProduct;
  int get inCartItems => _inCartItems + _countProduct;
  int get totalItems => _cart.totalItems;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      debugPrint('popular product list in Load good');
      _isLoaded = true;
      update();
    } else {
      debugPrint('response.statusCode popular ---   ${response.statusCode}');
    }
  }
  int _checkCount(int countProduct) {
    if ((_inCartItems + countProduct) < -1) {
      ThemeAppFun.printSnackBar('You can\'t reduce more !');

      return 0;
    } else if ((_inCartItems + countProduct) > 20) {
      ThemeAppFun.printSnackBar('You can\'t add more !');
      return 0;
    } else {
      return countProduct;
    }
  }

void initCount(ProductModel product, CartController cartController) {
    _countProduct = 0;
    _inCartItems = 0;
    _cart = cartController;
    _cart.existInCart(product) ? _inCartItems = _cart.getCount(product) : null;
  }
void setCountProduct(bool isIncroment, ProductModel product) {
    if (isIncroment) {
      _countProduct = _checkCount(_countProduct + 1);
      addProduct(product);
    } else {
      _countProduct = _checkCount(_countProduct - 1);
      addProduct(product);
    }
    update();
  }

  void addProduct(ProductModel product) {
    _cart.addItem(product, _countProduct);
    _countProduct = 0;
    _inCartItems = _cart.getCount(product);
    update();
  }


}
