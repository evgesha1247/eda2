import 'package:get/get.dart';
import '../../data/object/dish_object.dart';
import '../../routes/main_screens.dart';
import '../cart/cart_model.dart';

class DishDetailedModel extends GetxController {
  final cartController = Get.put(CartModel());

  Dish? dish;
  var number = 0;
  var subTotal = 0.0;

  void upDataDitalit() {
    number = cartController.numberDish(dish?.id);
    subTotal = cartController.subTotal(dish?.id);
    update();
  }

  void sub() {
    cartController.updataSubOne(dish?.id);
    upDataDitalit();
    update();
  }

  void add() {
    cartController.addItem(
        dishId: dish?.id,
        price: dish?.price,
        name: dish?.name,
      imgUrl: dish?.imgUrl,
    );
    upDataDitalit();
    update();
  }

  @override
  void onReady() {
    dish = Get.arguments['item'];
    upDataDitalit();
    update();
    super.onReady();
  }

  void showBack() {
    Get.back();
  }

  void showCart() {
    Get.toNamed(MainRoutes.detailsCart);
  }

  Future<void> toggFovarit() async {
    dish!.isFavorit = !dish!.isFavorit;
    await dish!.save();
    update();
  }
}
