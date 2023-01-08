import 'package:flutter/material.dart';

class MenuModel {
  final String text;
  final IconData icon;
  const MenuModel({
    required this.text,
    required this.icon,
  });
}

class MenuData {
  static const List<MenuModel> _menuData = [
    MenuModel(text: 'Home', icon: Icons.home),
    MenuModel(text: 'Menu', icon: Icons.restaurant_menu),
    MenuModel(text: 'favorite', icon: Icons.favorite),
    MenuModel(text: 'User', icon: Icons.person),
    MenuModel(text: '', icon: Icons.menu_outlined),
  ];
  static List<MenuModel> get listPage => _menuData.toList();
}
