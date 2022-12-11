
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:text/app/controllers/page_controller/menu_controller.dart';
import '../../../controllers/product_controller.dart';
import 'menu_body.dart';
import 'menu_filter.dart';
import 'menu_header.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MenuController>();
    return Scaffold(
      body: CustomScrollView(
        slivers: MediaQuery.of(context).size.width >= 370
            ? [
                MenuHeader(),
                MenuFilter(),
                MenuBody(),
              ]
            : [MenuBody()],
      ),




    );
  }
}
