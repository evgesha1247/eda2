import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/pages/indirect_pages/splash/splash_controller.dart';
import '../../../widgets/text/my_text.dart';

class SplashPage extends StatelessWidget {
  SplashPage({super.key});
  final controller = Get.put(SplashController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: BigText(
        text: 'тип анимация ',
        color: context.theme.cardColor,
      )),

    );
  }
}
