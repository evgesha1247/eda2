import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'controller/menu_controller.dart';
import '../../../theme/theme_app.dart';
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
          backgroundColor: ThemeAppColor.kBGColor,
        ),
        footer: MaterialClassicHeader(
          color: context.theme.primaryColor,
          backgroundColor: ThemeAppColor.kBGColor,
        ),
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
