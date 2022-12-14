import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/page_controller/menu_controller.dart';
import '../../../theme/theme_app.dart';
import '../../../widgets/icon/anumated_icon_favorit.dart';
import '../../../widgets/icon/custom_icon.dart';
import '../../../widgets/text/my_text.dart';

class MenuFilter extends StatelessWidget {
  const MenuFilter({super.key});
  final List<Filter> filterModel = const [
    Filter(text: 'Sort by', icon: Icons.short_text_outlined),
    Filter(text: 'Filter', icon: Icons.filter_alt_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    final listFilter = filterModel
        .map((Filter e) => FilterItem(text: e.text, icon: e.icon))
        .toList();
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: context.theme.scaffoldBackgroundColor,
      toolbarHeight: ThemeAppSize.kMenuHeaderFilter,
      flexibleSpace: Padding(
        padding: EdgeInsets.only(
          left: ThemeAppSize.kInterval12,
          bottom: ThemeAppSize.kInterval12,
        ),
        child: Row(
          children: [
            const _ButtonTogList(),
            Wrap(
              spacing: ThemeAppSize.kInterval12,
              children: listFilter,
            ),
          ],
        ),
      ),
    );
  }
}

class _TitleSort extends StatelessWidget {
  final SortMethod value;
  final String text;
  final IconData icon;
  _TitleSort({
    required this.value,
    required this.text,
    required this.icon,
  });
  final controller = Get.find<MenuController>();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: BigText(
        text: text,
        size: ThemeAppSize.kFontSize20,
        fontWeight: FontWeight.w400,
      ),
      subtitle: SmallText(
        text: 'Price',
        size: ThemeAppSize.kFontSize18 - 3,
      ),
      trailing: Icon(
        icon,
        color: context.theme.hintColor,
      ),
      leading: Radio(
        activeColor: context.theme.primaryColor,
        value: value,
        groupValue: controller.method,
        onChanged: (SortMethod? valueMethod) =>
            controller.setMethod(valueMethod),
      ),
    );
  }
}

class FilterItem extends StatelessWidget {
  final String text;
  final IconData icon;
  const FilterItem({super.key, required this.text, required this.icon});
  void sortByMass() {
    Get.defaultDialog(
      title: 'Sort by',
      titlePadding: EdgeInsets.only(top: ThemeAppSize.kInterval24),
      titleStyle: TextStyle(color: Get.context?.theme.hintColor),
      backgroundColor: Get.context?.theme.scaffoldBackgroundColor,
      radius: ThemeAppSize.kRadius12,
      content: GetBuilder<MenuController>(
        builder: (_) {
          return Column(
            children: [
              _TitleSort(
                text: 'low to high',
                value: SortMethod.lowToHigh,
                icon: Icons.arrow_circle_up,
              ),
              _TitleSort(
                text: 'high to low',
                value: SortMethod.highToLow,
                icon: Icons.arrow_circle_down,
              ),
            ],
          );
        },
      ),
      confirm: Container(
        width: 100,
        height: 4,
        decoration: BoxDecoration(
          color: Get.context?.theme.cardColor,
          borderRadius: BorderRadius.all(
            Radius.circular(
              ThemeAppSize.kRadius12,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => text == 'Sort by' ? sortByMass() : {},
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(ThemeAppSize.kRadius12),
          ),
          border: Border.all(color: context.theme.hintColor),
        ),
        child: Padding(
          padding: EdgeInsets.all(ThemeAppSize.kInterval12),
          child: Wrap(
            children: [
              SmallText(text: text, color: context.theme.hintColor),
              Icon(icon, color: context.theme.hintColor),
            ],
          ),
        ),
      ),
    );
  }
}

class _ButtonTogList extends StatelessWidget {
  const _ButtonTogList();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MenuController>(
      builder: (controller) {
        return AnimatedIconWidget(
          currIndex: (controller.listStatus == ListStatus.grid ? 0 : 1).obs,
          fun: () => controller.togStatusList(),
          widget1: WrapperIcon(
            child: Icon(
              Icons.grid_view,
              color: context.theme.hintColor,
            ),
          ),
          widget2: WrapperIcon(
              child: Icon(
            Icons.list,
            color: context.theme.hintColor,
          )),
        );
      },
    );
  }
}
