import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/widgets/text/my_text.dart';
import 'controller/menu_controller.dart';
import '../../../theme/theme_app.dart';

class MenuHeader extends StatelessWidget {
  const MenuHeader({super.key});
  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.width >= ThemeAppSize.kMaxMinWidth
        ? const _Search()
        : const _Title();
  }
}

class _Title extends StatelessWidget {
  const _Title();
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Center(
          child: Padding(
        padding: EdgeInsets.symmetric(vertical: ThemeAppSize.kInterval12),
        child: Row(
          children: [
            const Expanded(child: Divider()),
            BigText(text: 'menu_list'.tr),
            const Expanded(child: Divider()),
          ],
        ),
      )),
    );
  }
}

class _Search extends StatelessWidget {
  const _Search();
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
    final controller = Get.find<MenuControll>();
    return SliverAppBar(
      automaticallyImplyLeading: false,
      floating: true,
      pinned: false,
      snap: true,
      backgroundColor: context.theme.scaffoldBackgroundColor,
      toolbarHeight: ThemeAppSize.kMenuHeaderSearch - ThemeAppSize.kInterval5,
      flexibleSpace: Padding(
        padding: EdgeInsets.symmetric(horizontal: ThemeAppSize.kInterval12
        ),
        child: Center(
          child: TextField(
            autofocus: false,
            cursorColor: context.theme.hintColor,
            cursorWidth: 1.3,
            decoration: InputDecoration(
              isDense: true,
              fillColor: context.theme.hintColor,
              prefixIcon: Icon(
                Icons.search,
                color: context.theme.hintColor,
              ),
              hintText: 'search'.tr,
              hintStyle: TextStyle(color: context.theme.hintColor),
              enabledBorder: styleSearch,
              focusedBorder: styleSearch,
            ),
            onChanged: (text) => controller.searchFilter(text),
          ),
        ),
        //  ),
      ),
    );
  }
}
