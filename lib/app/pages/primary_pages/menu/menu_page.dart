import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/controllers/menu_controller.dart';
import '../../../controllers/product_controller.dart';
import 'menu_body.dart';
import 'menu_filter.dart';
import 'menu_header.dart';

class MenuPage extends StatelessWidget {
  MenuPage({Key? key}) : super(key: key);
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
        processingText: 'processingText',
        processedText: 'processedText',
        noMoreText: 'noMoreText',
        failedText: 'failedText',
      );
  final controller = Get.find<MenuController>();
  @override
  Widget build(BuildContext context) {
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
