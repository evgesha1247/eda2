import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/factory/widget_factory.dart';
import 'package:text/app/routes/main_screens.dart';
import '../../theme/theme_app.dart';
import '../../widgets/text/big_text.dart';

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

  _navigationToHome() {
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(MainRoutes.appHome);
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: Center(
        child: BigText(
          text: 'Good day ${user?.displayName ?? ' '}',
          color: ThemeAppColor.kFrontColor,
        ),
      ),
    );
  }
}
