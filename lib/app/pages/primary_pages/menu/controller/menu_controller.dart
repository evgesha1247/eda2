import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/product_controller.dart';
import '../../../../models/products_model.dart';
import '../model/filter_model.dart';

class MenuController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    initProductControllerr(Get.find<ProductController>());
  }

///////////// Tog list to grid
  late RenderingMethod renderingMethod = RenderingMethod.grid;
  void togStatusList() {
    renderingMethod = renderingMethod == RenderingMethod.list
        ? RenderingMethod.grid
        : RenderingMethod.list;
    update();
  }

///////////// Refresh Page
  Future<void> onRefresh(refreshController) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      initProductControllerr(Get.find<ProductController>());
      refreshController.refreshCompleted();
      refreshController.headerStatus;
    } catch (e) {
      refreshController.refreshFailed();
      debugPrint('refreshController  ---  $e');
    }
    update();
  }

///////////// Init product
  List<ProductModel> _allProductList = [];
  List<ProductModel> _filterList = [];
  List<ProductModel> get filterList => _filterList;

  void initProductControllerr(ProductController controller) {
    _allProductList = [];
    for (var element in controller.popularProductList) {
      if (!_allProductList.contains(element)) {
        _allProductList.add(element);
      }
    }

    for (var element in controller.recommendedProductList) {
      if (!_allProductList.contains(element)) {
        _allProductList.add(element);
      }
    }
    for (var element in controller.productMenuList) {
      if (!_allProductList.contains(element)) {
        _allProductList.add(element);
      }
    }

    _filterList = _allProductList;
    update();
  }

///////////// Sort /////////////

///////////// search
  searchFilter(String text) {
    if (text.isNotEmpty) {
      _filterList = [];
      _filterList = _allProductList
          .where((element) => element.name
              .toString()
              .toLowerCase()
              .contains(RegExp(text.toLowerCase())))
          .toList();
    } else {
      _filterList = _allProductList;
    }

    update();
  }

///////////// sortBy
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

///////////// sortRange
  late RangeValues filterValue;
  get priceRange => '${filterValue.start.round()}-${filterValue.end.round()}\$';
  var listPrice = <double>[];

  Map<String, bool> mapCategory = {};
  List<ProductModel> temp = [];
  onSelectChip(value, String key) {
    mapCategory.update(key, (v) => value);
    _filterList = _allProductList.where((element) {
      for (var e in mapCategory.entries) {
        if (e.value && e.key == element.category) {
          return true;
        }
      }
      return false;
    }).toList();

    _filterList = _filterList.isEmpty ? _allProductList : _filterList;
    temp = _filterList;
    update();
  }

  initFilterValue() {
    for (var element in _allProductList) {
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

    _filterList = temp
        .where((element) => (element.price! >= filterValue.start.round() &&
            element.price! <= filterValue.end.round()))
        .toList();

    update();
  }
}
