import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/pages/indirect_pages/splash/splash_model.dart';
import '../../../theme/theme_app.dart';
import '../../../widgets/text/my_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final dynamic user;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    try {
      user = FirebaseAuth.instance.currentUser;
    } catch (e) {
      user = null;
    }
    Get.put(SplashModel());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            BigText(
              text: 'Good day ${user?.displayName ?? ' '}',
              color: ThemeAppColor.kFrontColor,
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
