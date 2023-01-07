// ignore_for_file: unnecessary_this

class Product {
  late List<ProductModel> _products;
  List<ProductModel> get products => _products;
  Product({required products}) {
    this._products = products;
  }

  Product.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      _products = <ProductModel>[];
      json['products'].forEach((v) {
        _products.add(ProductModel.fromJson(v));
      });
    }
  }
}

class ProductModel {
  int? id;
  String? name;
  String? description;
  int? price;
  String? img;
  ProductModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.img,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "price": this.price,
      "description": this.description,
      "img": this.img,
    };
  }
}
