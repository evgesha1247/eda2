import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages/primary_pages/menu/menu_filter.dart';
import 'product_controller.dart';
import '../models/products_model.dart';

enum SortMethod { lowToHigh, highToLow, reset }
class Filter {
  final String text;
  final IconData icon;
  const Filter({
    required this.text,
    required this.icon,
  });
}

class MenuController extends GetxController {

  bool _isListGrid = true;
  bool get isListGrid => _isListGrid;
  SortMethod? method = SortMethod.reset;









  final List<ProductModel> _productList = [];
  List<ProductModel> get prosuct => _productList;

  List<ProductModel> _filterList = [];
  List<ProductModel> get filterList => _filterList;

  ProductController? productsController;

  void initProductControllerr(ProductController productController) {
    productsController = productController;
    _productList.addAll(
      productsController!.popularProductList +
          productsController!.recommendedProductList,
    );
    _filterList = _productList;
  }

  @override
  void onInit() {
    super.onInit();
    initProductControllerr(Get.find<ProductController>());
  }

///////////////////////////// Sort ///////////////////////

  searchFilter(String text) {
    if (text.isNotEmpty) {
      _filterList = [];
      _filterList = _productList
          .where((element) => element.name
              .toString()
              .toLowerCase()
              .contains(RegExp(text.toLowerCase())))
          .toList();
    } else {
      _filterList = _productList;
    }

    update();
  }

  sortBy() {
    switch (method) {
      case SortMethod.lowToHigh:
        _filterList.sort((a, b) => a.price!.compareTo(b.price!));
        break;
      case SortMethod.highToLow:
        _filterList.sort((a, b) => b.price!.compareTo(a.price!));
        break;
      default:
        _filterList;
    }
  }

  void setMethod(SortMethod? valueMethod) {
    method = valueMethod;
    sortBy();
    update();
  }

  void togStatusList() {
    _isListGrid = !_isListGrid;
    update();
  }
}
