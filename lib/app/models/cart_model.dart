import 'package:text/app/models/products_model.dart';

class CartModel {
  int? id;
  String? name;
  int? price;
  String? img;
  int? count;
  String? time;
  bool? isExit;
  ProductModel? product;

  CartModel({
    this.id,
    this.name,
    this.product,
    this.price,
    this.img,
    this.count,
    this.time,
    this.isExit,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    count = json['count'];
    img = json['img'];
    time = json['time'];
    isExit = json['isExit'];
    product = ProductModel.fromJson(json['product']);
  }
}
