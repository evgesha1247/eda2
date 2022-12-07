import 'package:get/get.dart';
import 'package:text/app/models/products_model.dart';

import '../data/repository/favorite_repo.dart';
import '../models/favorite_model.dart';

class FavoriteController extends GetxController {
  final FavoriteRepo favoriteRepo;
  FavoriteController({required this.favoriteRepo});

  final Map<int, FavoriteModel> _favoriteList = {};
  List<FavoriteModel> get getFavoriteList =>
      _favoriteList.entries.map((e) => e.value).toList();

  // проверка на наличение элемента в списке
  bool existInFavorites(ProductModel product) =>
      (_favoriteList.containsKey(product.id));

  //// LOCAL
  List<FavoriteModel> _itemsLocal = [];

  List<FavoriteModel> getItemsListLocal() {
    setFavoritLocal = favoriteRepo.getFavoriteList();
    return _itemsLocal;
  }

  set setFavoritLocal(List<FavoriteModel> items) {
    _itemsLocal = items;
    for (var i = 0; i < _itemsLocal.length; i++) {
      _favoriteList.putIfAbsent(
          _itemsLocal[i].product!.id!, () => _itemsLocal[i]);
    }
    update();
  }

  // добавление
  void upDataFavoriteList(ProductModel product) {
    if (existInFavorites(product)) {
      _favoriteList.remove(product.id);
    } else {
      _favoriteList.putIfAbsent(
        product.id!,
        () => FavoriteModel(
          id: product.id,
          product: product,
          isFavorite: true,
        ),
      );
    }

    favoriteRepo.addToFavoriteList(getFavoriteList);
    update();
  }





  // void upDataFavoriteList(ProductModel product) {
  //   if (!existInFavorites(product)) {
  //     _favoriteList.add(product);
  //   } else {
  //     _favoriteList.remove(product);
  //   }

  //   update();
  // }
}
