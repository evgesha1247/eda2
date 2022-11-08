import 'package:get/get.dart';
import '../../data/object/dish_object.dart';
import '../../routes/main_screens.dart';

class DishDetailedModel extends GetxController {
  Dish? dish;
  @override
  void onReady() {
    dish = Get.arguments['item'];
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
