import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ModelMenuGuiding {
  final String text;
  final IconData icon;
  const ModelMenuGuiding({
    required this.text,
    required this.icon,
  });
}

class DataMenuGuiding {
  final List<ModelMenuGuiding> _menuData = [
    ModelMenuGuiding(text: 'home'.tr, icon: Icons.home),
    ModelMenuGuiding(text: 'menu'.tr, icon: Icons.restaurant_menu),
    ModelMenuGuiding(text: 'favorites'.tr, icon: Icons.favorite),
    ModelMenuGuiding(text: 'person'.tr, icon: Icons.person),
    const ModelMenuGuiding(text: '', icon: Icons.menu_outlined),
  ];
  List<ModelMenuGuiding> get listPage => _menuData.toList();
}
