import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'ui/screens_factory.dart/widget_factory.dart';

Future main() async {
  final factor = ScreensFactory();
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  await Hive.initFlutter();

  runApp(factor.makeMainApp());
}
