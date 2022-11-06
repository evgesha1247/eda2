// ignore_for_file: avoid_print, depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:text/firebase_options.dart';
import 'app/factory/widget_factory.dart';
import 'app/repository/auth_repo.dart';



Future<void> main() async {
  final factor = ScreensFactory.instance;
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    ).then((value) => Get.put(AuthRepo()));
  } catch (e) {
    print(
        '$e - крч , не можешь подключить облочные платформы на этом устройстве');
  }
  await Hive.initFlutter();
  runApp(factor.makeMainApp());
}
