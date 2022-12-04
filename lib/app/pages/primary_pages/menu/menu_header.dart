import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/menu_controller.dart';
import '../../../theme/theme_app.dart';
import '../../../widgets/icon/custom_icon.dart';

class MenuHeader extends StatelessWidget {
  MenuHeader({super.key});
  final controller = Get.find<MenuController>();
  final InputBorder styleSearch = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(ThemeAppSize.kRadius20)),
      borderSide: const BorderSide(
        color: ThemeAppColor.kFrontColor,
        width: 1.5,
        style: BorderStyle.solid,
      ),
  );

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: false,
      snap: true,
      backgroundColor: ThemeAppColor.kBGColor,
      toolbarHeight: ThemeAppSize.kMenuHeaderSearch,
      flexibleSpace: Padding(
        padding: EdgeInsets.only(
          bottom: ThemeAppSize.kInterval12,
        ),
        child: FlexibleSpaceBar(
          titlePadding: EdgeInsets.symmetric(
            horizontal: ThemeAppSize.kInterval12,
          ),
          title: Row(
            children: [
              Expanded(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}