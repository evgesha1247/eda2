import 'package:get/get.dart';
import 'package:text/app/models/products_model.dart';
import '../data/repository/cart_repo.dart';
import '../models/cart_model.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});

  final Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;

  void addItem(ProductModel product, int count) {
    if (_items.containsKey(product.id)) {
      _items.update(product.id!, (value) {
        return CartModel(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          count: value.count! + count,
          time: DateTime.now().toString(),
          isExit: true,
        );
      });
    } else {
      _items.putIfAbsent(
        product.id!,
        () {
          return CartModel(
            id: product.id,
            name: product.name,
            price: product.price,
            img: product.img,
            count: count,
            time: DateTime.now().toString(),
            isExit: true,
          );
        },
      );
    }
  }
}
