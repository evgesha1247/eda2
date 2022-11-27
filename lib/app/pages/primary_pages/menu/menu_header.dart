import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/menu_controller.dart';
import '../../../theme/theme_app.dart';
import '../../../widgets/icon/anumated_icon_favorit.dart';
import '../../../widgets/icon/custom_icon.dart';

class MenuHeader extends StatelessWidget {
  MenuHeader({super.key});
  final controller = Get.find<MenuController>();
  Widget _searchWidget() {
    InputBorder styleSearch = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(ThemeAppSize.kRadius20)),
      borderSide: const BorderSide(
        color: ThemeAppColor.kFrontColor,
        width: 1.5,
        style: BorderStyle.solid,
      ),
    );
    return Expanded(
      child: TextField(
        cursorColor: ThemeAppColor.kFrontColor,
        decoration: InputDecoration(
          isDense: true,
          fillColor: ThemeAppColor.kBGColor,
          prefixIcon: const CustomButtonIcon(
            child: Icon(
              Icons.search,
              color: ThemeAppColor.kFrontColor,
            ),
          ),
          hintText: 'Search',
          enabledBorder: styleSearch,
          focusedBorder: styleSearch,
        ),
        onChanged: (text) => controller.searchFilter(text),
      ),
    );
  }

  Widget _buttonTogListWidget() {
    return GetBuilder<MenuController>(
      builder: (controller) {
        return AnimatedIconWidget(
          currIndex: (controller.isListGrid ? 0 : 1).obs,
          fun: () => controller.togStatusList(),
          widget1: const CustomButtonIcon(child: Icon(Icons.grid_view)),
          widget2: const CustomButtonIcon(child: Icon(Icons.list)),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: false,
      snap: true,
      backgroundColor: ThemeAppColor.kBGColor,
      toolbarHeight: ThemeAppSize.kMenuHeaderSearch,
      flexibleSpace: Padding(
        padding: EdgeInsets.all(ThemeAppSize.kInterval5),
        child: Row(
          children: [
            _searchWidget(),
            _buttonTogListWidget(),
          ],
        ),
      ),
      // FlexibleSpaceBar(
      //   // titlePadding: EdgeInsets.symmetric(
      //   //   horizontal: ThemeAppSize.kInterval12,
      //   // ),
      //   title: Row(
      //     children: [
      //       _searchWidget(),
      //       _buttonTogListWidget(),
      //     ],
      //   ),
      // ),
    );
  }
}
