import 'dart:async';

import 'package:get/get.dart';
import 'package:text/app/controllers/cart_controller.dart';
import 'package:text/app/models/products_model.dart';
import '../data/repository/product_repo.dart';
import '../theme/theme_app.dart';

enum ProductStatusLoad {
  loading,
  error,
  received,
}

class ProductController extends GetxController {
  final ProductRepo productRepo;
  ProductController({
    required this.productRepo,
  });

  var _popularProductList = <ProductModel>[];
  var _recommendedProductList = <ProductModel>[];
  var _productMenuList = <ProductModel>[];


  List<ProductModel> get popularProductList => _popularProductList;
  List<ProductModel> get productMenuList => _productMenuList;
  List<ProductModel> get recommendedProductList => _recommendedProductList;

  /// load Recommended ///
  late ProductStatusLoad recommendedStatusLoad;
  Future<void> _getRecommendedProductList() async {
    Response response =
        await productRepo.getRecommendedProductList();
    if (response.statusCode == 200) {
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products!);
      recommendedStatusLoad = ProductStatusLoad.received;
      update();
    } else {
      recommendedStatusLoad = ProductStatusLoad.error;
    }
  }

  Future<void> _getProductMenuList() async {
    Response response = await productRepo.getProductMenuList();
    if (response.statusCode == 200) {
      _productMenuList = [];
      _productMenuList.addAll(Product.fromJson(response.body).products!);
      update();
    }
  }


  /// load Popular //
  late ProductStatusLoad popularStatusLoad;
  Future<void> _getPopularProductList() async {
    Response response = await productRepo.getPopularProductList();
    if (response.statusCode == 200) {
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products!);
      popularStatusLoad = ProductStatusLoad.received;
    } else {
      Future.delayed(
        const Duration(seconds: 2),
        () {
          popularStatusLoad = ProductStatusLoad.error;
          update();
        },
      );
    }
    update();
  }

  Future<void> getDataProduct() async {
    recommendedStatusLoad = ProductStatusLoad.loading;
    popularStatusLoad = ProductStatusLoad.loading;
    await _getPopularProductList();
    await _getRecommendedProductList();
    await _getProductMenuList();
    update();
  }

//////////////////////////////// _cart ////////////////////////////
  /// создание контролера корзины и чтение количесвта элементов в ней
  CartController? _cart;
  int _countForAdding = 0;
  int _inCartItems = 0;
  void initCountToCart(ProductModel product, CartController cartController) {
    _cart = cartController;
    _cart!.existInCart(product)
        ? _inCartItems = _cart!.getCountProduct(product)
        : null;
  }

  // вкид количества элемеентов
  void upDataCountProductInCart(bool isIncroment, ProductModel product) {
    _countForAdding = _checkCount(_countForAdding + (isIncroment ? 1 : -1));
    _addProductToCart(product);
    update();
  }

  // проверка на возможность add/sub данного количества
  int _checkCount(int countProduct) {
    if ((_inCartItems + countProduct) < -1) {
      ThemeAppFun.printSnackBar('You can\'t reduce more !');
      return 0;
    } else if ((_inCartItems + countProduct) > 20) {
      ThemeAppFun.printSnackBar('You can\'t add more ! ( max count 20 ) ');
      return 0;
    } else {
      return countProduct;
    }
  }

  // дабавлени / удаление для  корзины
  void _addProductToCart(ProductModel product) {
    _cart!.addItem(product, _countForAdding);
    _countForAdding = 0;
    _inCartItems = _cart!.getCountProduct(product);
    update();
  }

  ////////////////////////////////////////////////////////
  RxBool startAnimation = false.obs;
  Future<void> animationInit() async {
    await Future.delayed(const Duration(seconds: 1), () {
      startAnimation.value = true;
    });
  }





}
