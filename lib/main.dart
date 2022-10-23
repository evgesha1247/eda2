import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'ui/screens_factory.dart/widget_factory.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


Future main() async {
  final factor = ScreensFactory();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  runApp(factor.makeMainApp());
}
