import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/pages/indirect_pages/splash/splash_controller.dart';
import '../../../widgets/text/my_text.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            BigText(
              text: 'Good day',
              //color: context.theme.backgroundColor,
            ),
            // Lottie.network(
            //   'https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/A.json',
            //   controller: _controller,
            //   onLoaded: (composition) {
            //     _controller
            //       ..duration = composition.duration
            //       ..forward();
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
