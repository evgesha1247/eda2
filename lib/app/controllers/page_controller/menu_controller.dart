import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/theme/theme_app.dart';
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
  late RangeValues filterValue;
  get priceRange => '${filterValue.start.round()}-${filterValue.end.round()}\$';
  var listPrice = <double>[];

  Map<String, bool> mapCategory = {};

  onSelectChip(value, String key) {
    mapCategory.update(key, (v) => value);

    _filterList = _productList.where((element) {
      for (var el in mapCategory.entries) {
        if (el.value) {
          return el.key == element.category;
        }
      }
      return false;
    }).toList();

    update();
  }

  initFilterValue() {
    for (var element in _productList) {
      listPrice.addIf(!listPrice.contains(element.price!.toDouble()),
          element.price!.toDouble());
      mapCategory.addIf(!mapCategory.containsKey(element.category.toString()),
          element.category.toString(), false);
    }
    filterValue = RangeValues(listPrice.reduce(min), listPrice.reduce(max));

  }

  onChangedFilter(RangeValues values) {
    var interva = 3;
    if (values.end - values.start >= interva) {
      filterValue = values;
    } else {
      if (filterValue.start == values.start) {
        filterValue = RangeValues(
          filterValue.start,
          filterValue.start + interva,
        );
      } else {
        filterValue = RangeValues(
          filterValue.end - interva,
          filterValue.end,
        );
      }
    }
    _filterList = _productList
        .where((element) => (element.price! >= filterValue.start.round() &&
            element.price! <= filterValue.end.round()))
        .toList();

    update();
  }
}
