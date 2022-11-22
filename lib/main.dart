// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/widgets/app/my_app_widget.dart';
import 'package:text/firebase_options.dart';
import 'app/data/repository/auth_repo.dart';
import 'app/page/splash/splash_model.dart';
import '../../../helper/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dep.init();

  try {
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    ).then((value) => Get.put(AuthRepo()));
  } catch (e) {
    debugPrint('no initialize Firebase !!!');
    GetPlatform.isDesktop ? Get.put(SplashModel()) : null;
  }

  runApp(const MyAppWidget());
}
