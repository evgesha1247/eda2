import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../about/about_page.dart';
import 'controller/guiding_controller.dart';
import '../home/home_page.dart';
import '../menu/menu_page.dart';
import '../profile/profile_page.dart';

class StackPageGuiding extends StatelessWidget {
  const StackPageGuiding({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GuidingController>(
      builder: (controller) => IndexedStack(
        index: controller.currentIndexTab,
        children: const [
          HomePage(),
          MenuPage(),
          AboutPage(),
          ProfilePage(),
        ],
      ),
    );
  }
}
