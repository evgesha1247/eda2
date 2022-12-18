import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:text/app/widgets/text/my_text.dart';
import '../../../controllers/page_controller/menu_controller.dart';
import '../../../widgets/load/circular.dart';
import 'menu_body.dart';
import 'menu_filter.dart';
import 'menu_header.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MenuController>();
    return Scaffold(
      body: SmartRefresher(
        controller: controller.refreshController,
        onRefresh: controller.onRefresh,
        onLoading: controller.onRefresh,
        enablePullDown: true,
        enablePullUp: true,
        header: MaterialClassicHeader(
          color: context.theme.primaryColor,
          backgroundColor: context.theme.accentColor,
        ),
        footer: const _FooterLoad(),
        child: CustomScrollView(
          slivers: MediaQuery.of(context).size.width >= 370
              ? [
                  const MenuHeader(),
                  const MenuFilter(),
                  MenuBody(),
                ]
              : [MenuBody()],
        ),
      ),
    );
  }
}

class _FooterLoad extends StatelessWidget {
  const _FooterLoad();
  @override
  Widget build(BuildContext context) {
    return CustomFooter(
      builder: (context, mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          body = const SmallText(text: "No more Data");
        } else if (mode == LoadStatus.loading) {
          body = const CircularWidget();
        } else if (mode == LoadStatus.canLoading) {
          body = const SmallText(text: "loading . . . ");
        } else {
          body = const SmallText(text: "error");
        }
        return SizedBox(
          height: 80.0,
          child: Center(child: body),
        );
      },
    );
  }
}
