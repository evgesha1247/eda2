import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/controllers/page_controller/menu_controller.dart';
import 'menu_body.dart';
import 'menu_filter.dart';
import 'menu_header.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);
  ClassicFooter foot() => const ClassicFooter(
        noMoreText: 'noMoreText',
        failedText: 'failedText',
      );
  ClassicHeader head() => ClassicHeader(
        spring: SpringDescription.withDampingRatio(
          mass: 5,
          stiffness: .9,
          ratio: .9,
        ),
        armedText: 'armedText',
        readyText: 'readyText',

      );

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MenuController>();
    return Scaffold(
      body: EasyRefresh(
        controller: controller.easyRefreshController,
        header: head(),
        footer: foot(),
        onRefresh: () => controller.onRefresh(),
        onLoad: () => controller.onLoad(),
        child: CustomScrollView(
          slivers: MediaQuery.of(context).size.width >= 370
              ? const [
                  MenuHeader(),
                  MenuFilter(),
                  MenuBody(),
                ]
              : const [MenuBody()],
        ),
      ),
    );
  }
}
