import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/controllers/cart_controller.dart';
import 'package:text/app/models/products_model.dart';

import '../data/repository/product_repo.dart';
import '../models/cart_model.dart';
import '../theme/theme_app.dart';

class ProductController extends GetxController {
  final ProductRepo recommendedProductRepo;
  final ProductRepo popularProductRepo;
  ProductController({
    required this.recommendedProductRepo,
    required this.popularProductRepo,
  });

  List<dynamic> _popularProductList = [];
  List<dynamic> _recommendedProductList = [];

  List<dynamic> get productList =>
      _popularProductList + _recommendedProductList;

  List<dynamic> get popularProductList => _popularProductList;
  List<dynamic> get recommendedProductList => _recommendedProductList;

//// load Recommended ////////////////////////////////////////
  bool _isLoadedRecommended = false;
  bool get isLoadedRecommended => _isLoadedRecommended;

  Future<void> getRecommendedProductList() async {
    Response response =
        await recommendedProductRepo.getRecommendedProductList();
    if (response.statusCode == 200) {
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      debugPrint('recommended product list in Load good');
      _isLoadedRecommended = true;
      update();
    } else {
      _isLoadedRecommended = false;
      debugPrint("response.statusCode recommended --- ${response.statusCode}");
    }
  }

  //// load Popular ////////////////////////////////////////
  bool _isLoadedPopular = false;
  bool get isLoadedPopular => _isLoadedPopular;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      debugPrint('popular product list in Load good');
      _isLoadedPopular = true;
      update();
    } else {
      debugPrint('response.statusCode popular ---   ${response.statusCode}');
    }
  }
  //////////////////////////////////////////////////////

  late CartController _cart;
  List<CartModel> get cartList => _cart.getCartItems;

  int _countProduct = 0;
  int _inCartItems = 0;

  int get countProduct => _countProduct;
  int get inCartItems => _inCartItems + _countProduct;
  int get totalItems => _cart.totalItems;

  int _checkCount(int countProduct) {
    if ((_inCartItems + countProduct) < -1) {
      ThemeAppFun.printSnackBar('You can\'t reduce more !');
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
