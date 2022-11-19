import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/models/products_model.dart';

import '../data/repository/product_repo.dart';

//Recommended
class RecommendedProductController extends GetxController {
  static final to = Get.find<RecommendedProductController>();
  final ProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo});
  List<dynamic> _recommendedProductList = [];
  List<dynamic> get recommendedProductList => _recommendedProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getRecommendedProductList() async {
    Response response =
        await recommendedProductRepo.getRecommendedProductList();
    if (response.statusCode == 200) {
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      debugPrint('recommended product list in Load good');
      _isLoaded = true;
      update();
    } else {
      _isLoaded = false;
      debugPrint("response.statusCode recommended --- ${response.statusCode}");
    }
  }

}
