import 'package:flutter/material.dart';

class MenuData {
  final String text;
  final IconData icon;
  const MenuData({
    required this.text,
    required this.icon,
  });
}

class Menu {
  static const List<MenuData> _menuData = [
    MenuData(text: 'Home', icon: Icons.home),
    MenuData(text: 'Menu', icon: Icons.restaurant_menu),
    MenuData(text: 'favorite', icon: Icons.favorite),
    MenuData(text: 'User', icon: Icons.person),
    MenuData(text: '', icon: Icons.menu_outlined),
  ];
  static List<MenuData> get listPage => _menuData.toList();
}
