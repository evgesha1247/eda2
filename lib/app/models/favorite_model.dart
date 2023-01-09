import 'package:text/app/models/products_model.dart';

class FavoriteModel {
  int id;
  bool isFavorite;
  ProductModel product;

  FavoriteModel({
    required this.id,
    required this.product,
    required this.isFavorite,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      id: json['id'] as int,
      isFavorite: json['isFavorite'] as bool,
      product: ProductModel.fromJson(json['product']),
    );

  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "id": id,
      "isFavorite": isFavorite,
      "product": product.toJson()
    };
  }
}
