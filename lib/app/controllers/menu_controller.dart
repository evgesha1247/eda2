import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  bool isListGrid = true;
  void togStatusList() {
    isListGrid = !isListGrid;
    update();
  }

/////////////////////////////////////////////
  final EasyRefreshController _easyRefreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );
  get easyRefreshController => _easyRefreshController;

  Future<void> onRefresh() async {

    _easyRefreshController.finishRefresh();
    _easyRefreshController.resetFooter();
    initProductControllerr(Get.find<ProductController>());

  }

  Future<void> onLoad() async {
    _easyRefreshController.finishLoad(IndicatorResult.noMore);
  }

////// init all product/////////////////////
  final List<ProductModel> _productList = [];
  List<ProductModel> _filterList = [];
  List<ProductModel> get filterList => _filterList;


  void initProductControllerr(ProductController controller) {
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
