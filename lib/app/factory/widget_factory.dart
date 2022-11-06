import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/object/cart_object.dart';
import '../model/auth/auth_model.dart';
import '../model/auth/auth_screen.dart';
import '../model/favorite/favorite_model.dart';
import '../model/favorite/favorite_screen.dart';
import '../widgets/app/my_app_widget.dart';

class ScreensFactory {
  static final instance = ScreensFactory._();
  ScreensFactory._();
  Widget makeMainApp() => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => CartModel()),
        ],
        child: const MyAppWidget(),
      );

  /////// страница регестрации  ///////
  Widget makeAuth() => ChangeNotifierProvider(
        create: (context) => AuthModel(),
        child: const AuthScreen(),
      );

}
