import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/guiding_controller.dart';
import '../favorite/favorite_page.dart';
import '../home/home_page.dart';
import '../menu/menu_page.dart';
import '../profile/profile_page.dart';


class GuidingStackPage extends StatelessWidget {
  const GuidingStackPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GuidingController>(
      builder: (controller) => IndexedStack(
        index: controller.currentIndexTab,
        children: const [
          HomePage(),
          MenuPage(),
          FavoritePage(),
          ProfilePage(),
        ],
      ),
    );
  }
}
