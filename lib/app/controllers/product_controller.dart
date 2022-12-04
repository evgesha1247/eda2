import 'package:get/get.dart';
import 'package:text/app/controllers/cart_controller.dart';
import 'package:text/app/models/products_model.dart';
import '../data/repository/product_repo.dart';
import '../theme/theme_app.dart';
import 'favorite_controller.dart';

class ProductController extends GetxController {
  final ProductRepo recommendedProductRepo;
  final ProductRepo popularProductRepo;
  ProductController({
    required this.recommendedProductRepo,
    required this.popularProductRepo,
  });

  var _popularProductList = <ProductModel>[];
  var _recommendedProductList = <ProductModel>[];

  List<ProductModel> get popularProductList => _popularProductList;
  List<ProductModel> get recommendedProductList => _recommendedProductList;

  /// load Recommended ///
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

  /// load Popular ///
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




//////////////////////////// _cart //////////////////////
  CartController? _cart;
  int _countForAdding = 0;
  int _inCartItems = 0;

  //  создание контролера корзины и чтение количесвта элементов в ней
  void initCountToCart(ProductModel product, CartController cartController) {
    _cart = cartController;
    _cart!.existInCart(product)
        ? _inCartItems = _cart!.getCountProduct(product)
        : null;
  }

  // вкид количества элемеентов
  void upDataCountProductInCart(bool isIncroment, ProductModel product) {
    if (isIncroment) {
      _countForAdding = _checkCount(_countForAdding + 1);
      _addProductToCart(product);
    } else {
      _countForAdding = _checkCount(_countForAdding - 1);
      _addProductToCart(product);
    }
    update();
  }

  // проверка на возможность add/sub данного количества
  int _checkCount(int countProduct) {
    if ((_inCartItems + countProduct) < -1) {
      ThemeAppFun.printSnackBar('You can\'t reduce more !');
      return 0;
    } else if ((_inCartItems + countProduct) > 10) {
      ThemeAppFun.printSnackBar('You can\'t add more !');
      return 0;
    } else {
      return countProduct;
    }
  }

  // дабавлени / удаление для  корзины
  void _addProductToCart(ProductModel product) {
    print(_countForAdding);
    _cart!.addItem(product, _countForAdding);
    _countForAdding = 0;
    _inCartItems = _cart!.getCountProduct(product);
    update();
  }


////////////////////////// _favorite /////////////////////////////////
  ///  создание контролера фаворитов и чтение количесвта элементов в ней
  FavoriteController? favorite;
  void initFavoriteController(FavoriteController favoriteController) {
    favorite = favoriteController;
  }


}
