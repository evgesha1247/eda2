import 'package:get/get.dart';
import 'package:text/app/models/products_model.dart';

import '../data/repository/favorite_repo.dart';

class FavoriteController extends GetxController {
  final FavoriteRepo favoriteRepo;
  FavoriteController({required this.favoriteRepo});

  final List _favoriteList = [];
  List get favoriteList => _favoriteList.toList();

  bool existInFavorites(ProductModel product) {
    if (_favoriteList.contains(product)) {
      return true;
    } else {
      return false;
    }
  }

  void upDataFavoriteList(ProductModel product) {
    if (!existInFavorites(product)) {
      _favoriteList.add(product);
    } else {
      _favoriteList.remove(product);
    }

    update();
  }
}
