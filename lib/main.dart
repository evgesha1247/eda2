// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/widgets/app/my_app_widget.dart';
import 'package:text/firebase_options.dart';
import 'app/data/repository/auth_repo.dart';
import 'app/pages/indirect_pages/splash/splash_controller.dart';
import 'app/routes/main_routes.dart';
import 'app/theme/theme_controller.dart';
import 'helper/dependencies.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  ApiBindings().dependencies();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ).then((value) => Get.find<AuthRepo>());
  } catch (e) {
    GetPlatform.isDesktop
        ? SplashController()
            .loadData()
            .then((value) => Get.offAllNamed(MainRoutes.getGuiding))
        : null;
  }

  runApp(MyAppWidget());
}
