class CartModel {
  int? id;
  String? name;
  int? price;
  String? img;
  int? count;
  String? time;
  bool? isExit;

  CartModel({
    this.id,
    this.name,
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
  }
}
