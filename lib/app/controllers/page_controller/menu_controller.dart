
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../product_controller.dart';
import '../../models/products_model.dart';

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
  @override
  void onInit() {
    super.onInit();
    initProductControllerr(Get.find<ProductController>());
  }

  bool isListGrid = true;
  void togStatusList() {
    isListGrid = !isListGrid;
    update();
  }

/////////////////////////////////////////////
  //final _controller = StreamController<SwipeRefreshState>.broadcast();

  // get easyRefreshController => _controller;
  Future<void> onRefresh() async {
    print('onRefresh');
    //  _easyRefreshController.finishRefresh();
    // initProductControllerr(Get.find<ProductController>());
  }
  onLoad() {
    print('onLoad');
  }

////// init all product/////////////////////
  final List<ProductModel> _productList = [];
  List<ProductModel> _filterList = [];
  List<ProductModel> get filterList => _filterList;

  void initProductControllerr(ProductController controller) {
    print('qwe');
    if (_productList == []) {
      _productList.addAll(
          controller.popularProductList + controller.recommendedProductList);
    } else {
      for (var element in controller.popularProductList) {
        if (!_productList.contains(element)) {
          _productList.add(element);
        }
      }
      for (var element in controller.recommendedProductList) {
        if (!_productList.contains(element)) {
          _productList.add(element);
        }
      }
    }
    _filterList = _productList;
    update();
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

  SortMethod? method = SortMethod.reset;
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
}
