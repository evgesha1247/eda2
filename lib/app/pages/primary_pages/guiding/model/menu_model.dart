import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuModel {
  final String text;
  final IconData icon;
  const MenuModel({
    required this.text,
    required this.icon,
  });
}

class MenuData {
  final List<MenuModel> _menuData = [
    MenuModel(text: 'home'.tr, icon: Icons.home),
    MenuModel(text: 'menu'.tr, icon: Icons.restaurant_menu),
    MenuModel(text: 'favorites'.tr, icon: Icons.favorite),
    MenuModel(text: 'person'.tr, icon: Icons.person),
    const MenuModel(text: '', icon: Icons.menu_outlined),
  ];
  List<MenuModel> get listPage => _menuData.toList();
}
