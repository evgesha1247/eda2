import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/models/products_model.dart';
import 'package:text/app/data/repository/popular_product_pero.dart';

class PopularProductController extends GetxController {
  static final to = Get.find<PopularProductController>();
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      debugPrint('popular product list in Load good');
      _isLoaded = true;
      update();
    } else {
      _isLoaded = false;
      debugPrint('${response.statusCode}');
    }
  }
}
