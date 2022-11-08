import 'package:get/get.dart';
import 'package:text/app/routes/main_screens.dart';
import '../../data/object/dish_object.dart';

class DishDetailedModel extends GetxController {
  Dish? _dish;
  @override
  onReady() {
    print(Get.parameters['item']);
    print('wwwwwwwwwwwwwwww');
    super.onReady();
    if (Get.arguments != null) {
      _dish = Get.parameters['item'] as Dish?;
    }
    update();
  }
  Dish? get dish => _dish;
  void showMenu() => Get.back();
  void showCart() => Get.toNamed(MainRoutes.cart);

  Future<void> toggFovarit() async {
    _dish!.isFavorit = !_dish!.isFavorit;
    await _dish!.save();
    update();
  }
}
