import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:text/app/models/favorite_model.dart';
import '../../../utils/app_constants.dart';

class FavoriteRepo {
  // final SharedPreferences sharedStore;

  List<String> _favorite = [];
  final favoriteBox = Hive.box('favorites_list');


  List<FavoriteModel> getFavoriteList() {
    if (favoriteBox.containsKey(AppConstansts.FAVORITE_LIST)) {
      List<FavoriteModel> favoriteList = [];
      for (var element
          in favoriteBox.get(AppConstansts.FAVORITE_LIST)!) {
        favoriteList.add(FavoriteModel.fromJson(jsonDecode(element)));
      }
      return favoriteList;
    }
    return [];


  }

  void addToFavoriteList(List<FavoriteModel> favoriteList) {
    _favorite = [];
    for (var element in favoriteList) {
      _favorite.add(jsonEncode(element));
    }

    favoriteBox.put(AppConstansts.FAVORITE_LIST, _favorite);

    getFavoriteList();
  }

}
