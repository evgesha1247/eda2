import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/theme/theme_app.dart';
import 'package:flutter/services.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/page_controller/favorite_controller.dart';
import '../../controllers/product_controller.dart';
import '../../routes/main_routes.dart';

class MyAppWidget extends StatelessWidget {
  const MyAppWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return GetBuilder<ProductController>(builder: (_) {
      return GetBuilder<CartController>(builder: (_) {
        return GetBuilder<FavoriteController>(builder: (_) {
          return GetMaterialApp(
            title: 'Restaurant',
            theme: Themes.light,
            darkTheme: Themes.dark,
            getPages: MainRoutes.getPages,
            debugShowCheckedModeBanner: false,
            initialRoute: MainRoutes.getInitial,
          );
        });
      });
    });
  }
}
