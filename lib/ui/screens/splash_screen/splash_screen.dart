import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/ui/theme/theme_app.dart';
import 'package:text/ui/widgets/text/big_text.dart';

import '../../screens_factory.dart/widget_factory.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigationToHome();
  }

  _navigationToHome() async {
    final factor = ScreensFactory.instance;
    await Future.delayed(const Duration(seconds: 3), () {});
    Get.offAll(() => factor.makeGuiding());

  }


  @override
  Widget build(BuildContext context) {
    final User user = FirebaseAuth.instance.currentUser as User;
    return Scaffold(
      body: Center(
        child: BigText(
          text: 'Good day ${user.displayName ?? ' '}',
          color: ThemeAppColor.kFrontColor,
        ),
      ),
    );
  }
}
