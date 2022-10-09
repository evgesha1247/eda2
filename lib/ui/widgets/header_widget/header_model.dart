import 'package:flutter/material.dart';
import 'package:text/ui/navigations/main_navigation.dart';

class HeaderModel extends ChangeNotifier {
  void showCart(context) {
    Navigator.of(context).pushNamed(MainNavigationRouteName.cart);
  }
}
