import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'ui/screens_factory.dart/widget_factory.dart';

void main() async {
  final factor = ScreensFactory();
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(factor.makeMainApp());
}
