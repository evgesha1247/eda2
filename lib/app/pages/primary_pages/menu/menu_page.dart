// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:text/app/widgets/text/my_text.dart';
import 'controller/menu_controller.dart';
import '../../../theme/theme_app.dart';
import '../../../widgets/load/circular.dart';
import 'menu_body.dart';
import 'menu_filter/menu_filter.dart';
import 'menu_header.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MenuControll>();

    final RefreshController refreshController = RefreshController(
      initialRefreshStatus: RefreshStatus.idle,
      initialRefresh: false,
    );

    return Scaffold(
      body: SmartRefresher(
        controller: refreshController,
        onRefresh: () => controller.onRefresh(refreshController),
        onLoading: () => controller.onRefresh(refreshController),
        enablePullDown: true,
        enablePullUp: true,
        header: MaterialClassicHeader(
          color: context.theme.primaryColor,
          backgroundColor: context.theme.accentColor,
        ),
        footer: const _FooterLoad(),
        child: CustomScrollView(
          slivers: [
            const HeaderMenu(),
            if (context.width >= ThemeAppSize.kMaxMinWidth) const FilterMenu(),
            const BodyMenu(),
          ],
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
          body = const SmallText(text: "No more data");
        } else if (mode == LoadStatus.loading) {
          body = const CircularWidget();
        } else if (mode == LoadStatus.canLoading) {
          body = const SmallText(text: "loading . . . ");
        } else {
          body = const SmallText(text: "error");
        }
        return Center(child: body);
      },
    );
  }
}
