// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:text/app/model/splash/splash_model.dart';
import 'package:text/app/widgets/app/my_app_widget.dart';
import 'package:text/firebase_options.dart';
import 'app/repository/auth_repo.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    ).then((value) => Get.put(AuthRepo()));
  } catch (e) {
    // GetPlatform.isDesktop ? Get.put(SplashModel()) : null;
  }
  await Hive.initFlutter();
  runApp(const MyAppWidget());
}
