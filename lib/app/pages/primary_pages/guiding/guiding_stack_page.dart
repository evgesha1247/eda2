import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/widgets/text/my_text.dart';
import '../../indirect_pages/splash/splash_screen.dart';
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
class Example extends StatelessWidget {
  const Example({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(
        5,
        (index) => InkWell(
          onTap: () => Get.to(Example2(index: index)),
          child: Hero(
            tag: 'tag$index',
            child: const Image(
              image: NetworkImage(
                'https://sun9-27.userapi.com/impg/TUedgJjbroIBVzlqS7MBkQuH_vbiQMd5ZsypZg/2c3hQzSTQ2U.jpg?size=200x267&quality=96&sign=937556992f3caa1ed7c1e1c1e0dead32&c_uniq_tag=CkoJqUX0IX1b5MhGyvv-QBk0M1Hj3LLaUK2yrRHxa7g&type=album',
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Example2 extends StatelessWidget {
  final int index;
  const Example2({super.key, required this.index});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Image(
          image: NetworkImage(
            'https://sun2-11.userapi.com/impg/X_VXhgnQ9HPVws21YjpCF7iHWw_oCSDtthUmBQ/3sT_70cfNQE.jpg?size=750x1334&quality=96&sign=54abd00217d4b9883428f99c0dc5dff9&type=album,',
          ),
        ),
      ),
    );
  }
}
