import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/models/products_model.dart';
import 'package:text/app/data/repository/popular_product_pero.dart';
import 'package:text/app/theme/theme_app.dart';

class PopularProductController extends GetxController {
  static final to = Get.find<PopularProductController>();
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  int _countProduct = 0;
  int get countProduct => _countProduct;

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
  void setCountProduct(bool isIncroment) {
    if (isIncroment) {
      _countProduct = _checkCount(_countProduct + 1);
    } else {
      _countProduct = _countProduct = _checkCount(_countProduct - 1);
    }
    update();
  }

  int _checkCount(int countProduct) {
    if (countProduct < 0) {
      printSnackBar('You can\'t reduce more !');
      return 0;
    } else if (countProduct > 20) {
      printSnackBar('You can\'t add more !');
      return 20;
    } else {
      return countProduct;
    }
  }

  void printSnackBar(String message) {
    Get.snackbar(
      'Item count',
      message,
      backgroundColor: ThemeAppColor.kAccent.withOpacity(0.7),
      colorText: ThemeAppColor.kBGColor,
      duration: const Duration(milliseconds: 1200),
      margin: EdgeInsets.all(ThemeAppSize.kInterval12),
    );
  }

}
