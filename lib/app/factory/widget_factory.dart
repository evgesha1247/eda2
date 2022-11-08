import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/auth/auth_model.dart';
import '../model/auth/auth_screen.dart';

class ScreensFactory {
  static final instance = ScreensFactory._();
  ScreensFactory._();


  /////// страница регестрации  ///////
  Widget makeAuth() => ChangeNotifierProvider(
        create: (context) => AuthModel(),
        child: const AuthScreen(),
      );

}
