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
  List? img;
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
    img = (json['imgs']).map((e) {
      return Img.fromJson(e as Map<String, dynamic>);
    }).toList() as List<Img>;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "price": this.price,
      "description": this.description,
      "imgs": this.img?.map((e) => e.toJson),
    };
  }
}

class Img {
  final String imgURL;
  Img({required this.imgURL});

  factory Img.fromJson(Map<String, dynamic> json) {
    return Img(imgURL: json['imgURL'] as String);
  }

  Map<String, dynamic> toJson() {
    return {
      'imgURL': imgURL,
    };
  }

}
