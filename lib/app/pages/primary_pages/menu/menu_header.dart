import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/menu_controller.dart';
import '../../../theme/theme_app.dart';
import '../../../widgets/icon/custom_icon.dart';

class MenuHeader extends StatelessWidget {
  MenuHeader({super.key});
  final controller = Get.find<MenuController>();
  @override
  Widget build(BuildContext context) {
    final InputBorder styleSearch = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(ThemeAppSize.kRadius20)),
    borderSide: BorderSide(
        color: context.theme.hintColor,
        width: 1.5,
        style: BorderStyle.solid,
      ),
    );
    return SliverAppBar(
      floating: true,
      pinned: false,
      snap: true,
      backgroundColor: context.theme.scaffoldBackgroundColor,
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
                  cursorColor: context.theme.hintColor,
                  cursorWidth: 1.3,
                  decoration: InputDecoration(
                    isDense: true,
                    fillColor: context.theme.hintColor,
                    prefixIcon: WrapperIcon(
                      child: Icon(
                        Icons.search,
                        color: context.theme.hintColor,
                      ),
                    ),
                    hintText: 'Search',
                    hintStyle: TextStyle(color: context.theme.hintColor),
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
