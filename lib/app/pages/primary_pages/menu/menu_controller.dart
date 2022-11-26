import 'package:get/get.dart';

import '../../../controllers/product_controller.dart';
import '../../../models/products_model.dart';

enum SortMethod { lowToHigh, highToLow, reset }

class MenuController extends GetxController {
  bool _isListGrid = true;
  bool get isListGrid => _isListGrid;
  SortMethod? method = SortMethod.reset;

  final List<ProductModel> _productList = [];
  List<ProductModel> get prosuct => _productList;

  List<ProductModel> _filterList = [];
  List<ProductModel> get filterList => _filterList;

  ProductController? productsController;

  void initProductControllerr(ProductController productController) async {
    productsController = productController;
    _productList.addAll(
      productsController!.popularProductList +
          productsController!.recommendedProductList,
    );
    _filterList = _productList;
    print(_filterList);
    print(productsController!.popularProductList);
    print(productsController!.recommendedProductList);
  }

  MenuController() {
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

  void setMethod(SortMethod? valueMethod) {
    method = valueMethod;
    update();
  }

  void togStatusList() {
    _isListGrid = !_isListGrid;
    update();
  }
}
