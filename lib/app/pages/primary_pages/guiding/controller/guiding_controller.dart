import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuidingController extends GetxController {
  int _currentIndexTab = 0;
  IconData selectIcon = Icons.menu_outlined;
  int get currentIndexTab => _currentIndexTab;

  RxBool startAnimationMenu = false.obs;
  setCurrentIndexTab(int index) {
      _currentIndexTab = index;
      if (currentIndexTab == 1) {
        Timer(const Duration(milliseconds: 100), () {
            startAnimationMenu.value = true;
        });
      }
    update();
  }





  late AnimationController animatedContainer;
  void updatePage(icon, index) {
    if (icon == Icons.menu_outlined || selectIcon == icon) {
      animatedContainer.status == AnimationStatus.completed
          ? animatedContainer.reverse()
          : animatedContainer.forward();
    } else {
      selectIcon = icon;
      setCurrentIndexTab(index);
    }
    update();
  }
}
