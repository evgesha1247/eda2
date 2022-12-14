import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/widgets/app/my_app_widget.dart';
import 'app/controllers/cart_controller.dart';
import 'app/controllers/page_controller/favorite_controller.dart';
import 'app/controllers/product_controller.dart';
import 'app/data/repository/auth_repo.dart';
import 'app/routes/main_routes.dart';
import 'app/theme/theme_controller.dart';
import 'helper/dependencies.dart';


import '../../../firebase_options.dart';

// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';

Future<void> loadData() async {
  Get.find<ThemeAppController>().getThemeStatus();
  await Get.find<ProductController>().getDataProduct();
  Get.find<CartController>().getItemsListLocal();
  Get.find<FavoriteController>().getItemsListLocal();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThemeBindings().dependencies();
  await ControllersBindings().dependencies();
  await ApiBindings().dependencies();
  await AllPageBindings().dependencies();
  runApp(const MyAppWidget());
  Dependencies().init();
  await loadData();
}
