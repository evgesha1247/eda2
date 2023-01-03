
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class GuidingController extends GetxController {

  int _currentIndexTab = 0;
  IconData selectIcon = Icons.menu_outlined;
  get currentIndexTab => _currentIndexTab;

  setCurrentIndexTab(int? index) {
    if (index != null) {
      _currentIndexTab = index;
      update();
    }
  }
  late AnimationController animatedContainer;

  @override
  void onClose() {
    animatedContainer.dispose();
    super.onClose();
  }

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
