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
  @override


  Widget build(BuildContext context) {
    final controller = Get.find<MenuController>();

    return Scaffold(
      body: EasyRefresh(
        controller: controller.easyRefreshController,
        header: ClassicHeader(
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
        ),
        footer: ClassicFooter(
          noMoreText: 'noMoreText',
          failedText: 'failedText',
        ),
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
