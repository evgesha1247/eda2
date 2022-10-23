import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:text/firebase_options.dart';
import 'ui/screens_factory.dart/widget_factory.dart';



Future<void> main() async {
  final factor = ScreensFactory();
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  } catch (e) {
    print(
        '$e - крч , не можешь подключить облочные платформы на этом устройстве');
  }
  await Hive.initFlutter();
  runApp(factor.makeMainApp());
}
