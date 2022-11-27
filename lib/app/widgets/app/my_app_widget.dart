import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/theme/theme_app.dart';
import 'package:flutter/services.dart';
import '../../controllers/product_controller.dart';
import '../../routes/main_routes.dart';

class MyAppWidget extends StatelessWidget {
  const MyAppWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return GetBuilder<ProductController>(
      builder: (_) {
        return GetMaterialApp(
          title: 'Restaurant',
          theme: ThemeData(
            fontFamily: 'Mariupol',
            scaffoldBackgroundColor: ThemeAppColor.kBGColor,
              textTheme: stText()
          ),
          debugShowCheckedModeBanner: false,
          getPages: MainRoutes.getPages,
          initialRoute: MainRoutes.getInitial(),
        );
      },
    );
  }
}



TextTheme? stText() {
  return const TextTheme(
    headline6: TextStyle(
      fontSize: 33,
    ),
  );
}
