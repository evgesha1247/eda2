import 'package:text/app/models/products_model.dart';

class FavoriteModel {
  int? id;
  bool? isFavorite;
  ProductModel? product;

  FavoriteModel({
    this.id,
    this.product,
    this.isFavorite,
  });

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    isFavorite = json['isFavorite'];
    product = ProductModel.fromJson(json['product']);
  }

  Map<String, dynamic> toJson() {
    return {"isFavorite": isFavorite, "product": product!.toJson()};
  }
}
