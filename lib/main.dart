import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/widgets/app/my_app_widget.dart';
import 'app/controllers/cart_controller.dart';
import 'app/controllers/page_controller/favorite_controller.dart';
import 'app/controllers/product_controller.dart';
import 'app/theme/theme_controller.dart';
import 'helper/dependencies.dart';

Future<void> loadData() async {
  Get.find<ThemeAppController>().getThemeStatus();
  await Get.find<ProductController>().getDataProduct();
  Get.find<CartController>().getCartListLocal();
  //Get.find<CartController>().getCartHistoryListLocal();
  Get.find<FavoriteController>().getItemsListLocal();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThemeBindings().dependencies();
  await ControllersBindings().dependencies();
  await ApiBindings().dependencies();
  await AllPageBindings().dependencies();
  runApp(const MyAppWidget());
  await loadData();
  Dependencies().init();
}
