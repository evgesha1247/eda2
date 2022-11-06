
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/model/splash/splash_model.dart';
import '../../theme/theme_app.dart';
import '../../widgets/text/big_text.dart';

class SplashScreen extends GetView<SplashModel> {
  const SplashScreen({super.key});
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
