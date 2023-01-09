import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../product_controller.dart';
import '../../models/products_model.dart';

enum SortMethod { lowToHigh, highToLow, aToZ, zToA, reset }

enum ListStatus { list, grid }

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

  ListStatus listStatus = ListStatus.grid;
  void togStatusList() {
    listStatus =
        (listStatus == ListStatus.list) ? ListStatus.grid : ListStatus.list;
    update();
  }

/////////////////////////////////////////////

  // get easyRefreshController => _controller;
  Future<void> onRefresh(refreshController) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      initProductControllerr(Get.find<ProductController>());
      refreshController.refreshCompleted();
      //  refreshController.loadComplete();
      refreshController.headerStatus;
    } catch (e) {
      refreshController.refreshFailed();
      debugPrint('refreshController  ---  $e');
    }
    update();
  }

////// init all product/////////////////////
  List<ProductModel> _productList = [];
  List<ProductModel> _filterList = [];
  List<ProductModel> get filterList => _filterList;

  void initProductControllerr(ProductController controller) {
    _productList = [];
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
  _sortBy() {
    switch (method) {
      case SortMethod.lowToHigh:
        _filterList.sort((a, b) => a.price!.compareTo(b.price!));
        break;
      case SortMethod.highToLow:
        _filterList.sort((a, b) => b.price!.compareTo(a.price!));
        break;
      case SortMethod.aToZ:
        _filterList.sort((a, b) => a.name!.compareTo(b.name!));
        break;
      case SortMethod.zToA:
        _filterList.sort((a, b) => b.name!.compareTo(a.name!));
        break;
      default:
        _filterList;
    }
  }

  void setMethod(SortMethod? valueMethod) {
    method = valueMethod;
    _sortBy();
    update();
  }

  ///// filter
  late var filterValue = RangeValues(1, 2);
  var listPrice = <double>[];
  initFilterValue() {
    listPrice = [];
    for (var element in _productList) {
      listPrice.add(element.price!.toDouble());
    }
    filterValue = RangeValues(listPrice.reduce(min), listPrice.reduce(max));
  }

  onChangedFilter(RangeValues values) {
    filterValue = values;
    update();
  }
}
