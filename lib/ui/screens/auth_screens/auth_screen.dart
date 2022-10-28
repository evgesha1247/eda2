import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:text/ui/screens_factory.dart/widget_factory.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final factor = ScreensFactory();
    return factor.makeRegister();
  }
}
