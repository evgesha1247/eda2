import 'package:get/get.dart';
import '../../data/object/dish_object.dart';
import '../../routes/main_screens.dart';
import '../cart/cart_model.dart';

class DishDetailedModel extends GetxController {
  final cartController = Get.put(CartModel());

  void upData() {
    cartController.updataSubOne(dish?.id);
    number.value = cartController.numberItem(dish?.id);
    subTotal.value = cartController.subTotal(dish?.id);
    update();
  }

  void add() {
    cartController.addItem(
        dishId: dish?.id,
        price: dish?.price,
        name: dish?.name,
        imgUrl: dish?.imgUrl);
    number.value = cartController.numberItem(dish?.id);
    subTotal.value = cartController.subTotal(dish?.id);
    update();
  }


  Dish? dish;
  var number = 0.obs;
  var subTotal = 0.0.obs;

  @override
  void onReady() {
    dish = Get.arguments['item'];
    number.value = cartController.numberItem(dish?.id);
    subTotal.value = cartController.subTotal(dish?.id);
    update();
    super.onReady();
  }



  void showBack() {
    Get.back();
  }

  void showCart() {
    Get.toNamed(MainRoutes.cart);
  }

  Future<void> toggFovarit() async {
    dish!.isFavorit = !dish!.isFavorit;
    await dish!.save();
    update();
  }
}
