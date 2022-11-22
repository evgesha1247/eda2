import 'package:get/get.dart';
import 'package:text/app/controllers/cart_controller.dart';
import 'package:text/app/models/products_model.dart';
import '../data/repository/product_repo.dart';
import '../theme/theme_app.dart';

class ProductController extends GetxController {
  final ProductRepo recommendedProductRepo;
  final ProductRepo popularProductRepo;
  ProductController({
    required this.recommendedProductRepo,
    required this.popularProductRepo,
  });

  List<dynamic> _popularProductList = [];
  List<dynamic> _recommendedProductList = [];

  List<dynamic> get productList =>
      _popularProductList + _recommendedProductList;

  List<dynamic> get popularProductList => _popularProductList;
  List<dynamic> get recommendedProductList => _recommendedProductList;

//// load Recommended ////////////////////////////////////////
  bool _isLoadedRecommended = false;
  bool get isLoadedRecommended => _isLoadedRecommended;

  Future<void> getRecommendedProductList() async {
    Response response =
        await recommendedProductRepo.getRecommendedProductList();
    if (response.statusCode == 200) {
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      _isLoadedRecommended = true;
      update();
    }
  }

  //// load Popular ////////////////////////////////////////
  bool _isLoadedPopular = false;
  bool get isLoadedPopular => _isLoadedPopular;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoadedPopular = true;
      update();
    }
  }
  //////////////////////////////////////////////////////

  CartController? _cart;
  int _countForAdding = 0;
  int _inCartItems = 0;

  //  создание контролера корзины и чтение количесвта элементов в ней
  void initCount(ProductModel product, CartController cartController) {
    _cart = cartController;
    _cart!.existInCart(product)
        ? _inCartItems = _cart!.getCountProduct(product)
        : null;
  }

// дабавлени / удаление с корзины c проверкой
  void upDataCountProductInCart(bool isIncroment, ProductModel product) {
    if (isIncroment) {
      _countForAdding = _checkCount(_countForAdding + 1);
      _addProduct(product);
    } else {
      _countForAdding = _checkCount(_countForAdding - 1);
      _addProduct(product);
    }
    update();
  }

  int _checkCount(int countProduct) {
    if ((_inCartItems + countProduct) < -1) {
      ThemeAppFun.printSnackBar('You can\'t reduce more !');
      return 0;
    } else {
      return countProduct;
    }
  }

  void _addProduct(ProductModel product) {
    _cart!.addItem(product, _countForAdding);
    _countForAdding = 0;
    _inCartItems = _cart!.getCountProduct(product);
    update();
  }
}
