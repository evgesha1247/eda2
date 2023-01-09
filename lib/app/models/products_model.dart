class Product {
  List<ProductModel>? products;

  Product({this.products});

  Product.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <ProductModel>[];
      json['products'].forEach((v) {
        products!.add(ProductModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductModel {
  String? category;
  String? description;
  int? id;
  List<Imgs>? imgs;
  String? name;
  int? price;

  ProductModel(
      {this.category,
      this.description,
      this.id,
      this.imgs,
      this.name,
      this.price});

  ProductModel.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    description = json['description'];
    id = json['id'];
    if (json['imgs'] != null) {
      imgs = <Imgs>[];
      json['imgs'].forEach((v) {
        imgs!.add(Imgs.fromJson(v));
      });
    }
    name = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category'] = category;
    data['description'] = description;
    data['id'] = id;
    if (imgs != null) {
      data['imgs'] = imgs!.map((v) => v.toJson()).toList();
    }
    data['name'] = name;
    data['price'] = price;
    return data;
  }
}

class Imgs {
  String? imgURL;

  Imgs({this.imgURL});

  Imgs.fromJson(Map<String, dynamic> json) {
    imgURL = json['imgURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imgURL'] = imgURL;
    return data;
  }
}
