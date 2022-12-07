import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:text/app/models/favorite_model.dart';
import '../../../utils/app_constants.dart';

class FavoriteRepo {
  final SharedPreferences sharedStore;
  FavoriteRepo({required this.sharedStore});

  List<String> _favorite = [];

  List<FavoriteModel> getFavoriteList() {
    if (sharedStore.containsKey(AppConstansts.FAVORITE_LIST)) {
      List<FavoriteModel> favoriteList = [];
      for (var element
          in sharedStore.getStringList(AppConstansts.FAVORITE_LIST)!) {
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
    sharedStore.setStringList(AppConstansts.FAVORITE_LIST, _favorite);
    getFavoriteList();
  }

}
