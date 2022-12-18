import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/page_controller/menu_controller.dart';
import '../../../theme/theme_app.dart';
import '../../../widgets/icon/custom_icon.dart';

class MenuHeader extends StatelessWidget {
  const MenuHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final InputBorder styleSearch = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(ThemeAppSize.kRadius12)),
    borderSide: BorderSide(
        color: context.theme.hintColor,
        width: 1.5,
        style: BorderStyle.solid,
      ),
    );
    final controller = Get.find<MenuController>();
    return SliverAppBar(
automaticallyImplyLeading: false,
      floating: true,
      pinned: false,
      snap: true,
      backgroundColor: context.theme.scaffoldBackgroundColor,
      toolbarHeight: ThemeAppSize.kMenuHeaderSearch,
      flexibleSpace: Padding(
        padding: EdgeInsets.all(ThemeAppSize.kInterval12
        ),
        child: Row(
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
        //  ),
      ),
    );
  }
}
