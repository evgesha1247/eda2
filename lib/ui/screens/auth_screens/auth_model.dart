import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../navigations/main_navigation.dart';

class AuthModel extends ChangeNotifier {
  void showRegister(BuildContext context) =>
      Navigator.pushNamed(context, MainNavigationRouteName.register);
  void showLogin(BuildContext context) =>
      Navigator.pushNamed(context, MainNavigationRouteName.login);

}
