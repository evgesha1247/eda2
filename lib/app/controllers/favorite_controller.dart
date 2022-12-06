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

  bool existInFavorites(ProductModel product) =>
      (_favoriteList.containsKey(product.id));



  // void upDataFavoriteList(ProductModel product) {
  //   if (!existInFavorites(product)) {
  //     _favoriteList.add(product);
  //   } else {
  //     _favoriteList.remove(product);
  //   }

  //   update();
  // }
}
