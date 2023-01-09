import 'package:text/app/models/products_model.dart';

class CartModel {
  int? id;
  int? count;
  String? time;
  bool? isExit;
  ProductModel? product;

  CartModel({
    this.id,
    this.product,
    this.count,
    this.time,
    this.isExit,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    id = json['id'];
    time = json['time'];
    isExit = json['isExit'];
    product = ProductModel.fromJson(json['product']);
  }

  Map<String, dynamic> toJson() {
    return {
      "count": count,
      "id": id,
      "time": time,
      "isExit": isExit,
      "product": product!.toJson(),
    };
  }
}
