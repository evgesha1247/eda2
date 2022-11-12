import 'package:get/get.dart';
import '../../data/object/dish_object.dart';
import '../../routes/main_screens.dart';
import '../cart/cart_model.dart';

class DishDetailedModel extends GetxController {
  final cartController = Get.put(CartModel());

  late final Dish dish;
  final _count = 0.obs;
  final _total = 0.0.obs;
  get count => _count.value.toString();
  get total => _total.value.toString();

  void countUpData() {
    cartController.cart[dish] != null
        ? _count.value = cartController.cart[dish]
        : _count.value = 0;
    _total.value = dish.price * _count.value;
  }

  void sub() {
    cartController.removeProduct(dish);
    countUpData();
  }

  void add() {
    cartController.addProduct(dish);
    countUpData();
  }

  @override
  void onInit() {
    dish = Get.arguments['item'];
    super.onInit();
  }

  @override
  void onReady() {
    countUpData();
    super.onReady();
  }

  void showCart() {
    Get.toNamed(MainRoutes.detailsCart);
  }

  Future<void> toggFovarit() async {
    dish.isFavorit = !dish.isFavorit;
    await dish.save();
    update();
  }
}
