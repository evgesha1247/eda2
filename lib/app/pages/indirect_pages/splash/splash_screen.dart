import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rive/rive.dart';
import 'package:text/app/pages/indirect_pages/splash/splash_controller.dart';

class SplashPage extends StatelessWidget {
  SplashPage({super.key});
  final controller = Get.put(SplashController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Lottie.network(
                'https://assets4.lottiefiles.com/packages/lf20_6yhhrbk6.json',
              ),
            ),
          ],
        ),
      ),

    );
  }
}
