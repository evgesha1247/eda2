import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:text/firebase_options.dart';
import 'ui/screens_factory.dart/widget_factory.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';



Future<void> main() async {
  final factor = ScreensFactory();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  runApp(factor.makeMainApp());
}
