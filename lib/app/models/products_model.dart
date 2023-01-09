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
  int id;
  String name;
  String description;
  String category;
  int price;
  List? img;
  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.price,
    required this.img,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      category: json['category'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      img: (json['imgs']).map((e) => e['imgURL']).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "category": this.category,
      "name": this.name,
      "price": this.price,
      "description": this.description,
      "imgs": this.img?.map((e) => {'imgURL': e}),
    };
  }
}
class ProductImg {
  final String imgURL;
  ProductImg({
    required this.imgURL,
  });
  factory ProductImg.fromJson(Map<String, dynamic> json) {
    return ProductImg(
      imgURL: json['imgURL'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return <String, dynamic>{'imgURL': imgURL
    };
  }



}
