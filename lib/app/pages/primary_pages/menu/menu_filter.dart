import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import '../../../controllers/page_controller/menu_controller.dart';
import '../../../theme/theme_app.dart';
import '../../../widgets/icon/anumated_icon_favorit.dart';
import '../../../widgets/icon/custom_icon.dart';
import '../../../widgets/show_dialog/custom_show_dialog.dart';
import '../../../widgets/text/my_text.dart';

const List<Filter> filterModel = [
  Filter(text: 'Sort by', icon: Icons.short_text_outlined),
  Filter(text: 'Filter', icon: Icons.filter_alt_outlined),
];

class MenuFilter extends StatelessWidget {
  const MenuFilter({super.key});
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          SizedBox(width: ThemeAppSize.kInterval12),
          const _ButtonTogList(),
          ...List.generate(
            filterModel.length,
            (index) => Row(
              children: [
                SizedBox(width: ThemeAppSize.kInterval12),
                _FilterItem(item: filterModel[index]),
              ],
            ),
          ).toList(),
        ],
      ),
    );
  }
}

class _FilterItem extends StatelessWidget {
  final Filter item;
  const _FilterItem({required this.item});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => sortByMass(item.text),
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: ThemeAppSize.kInterval12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(ThemeAppSize.kRadius12),
            ),
            border: Border.all(color: context.theme.hintColor),
          ),
          height: ThemeAppSize.kMenuHeaderSearch - ThemeAppSize.kInterval24,
          child: Row(
            children: [
              SmallText(text: item.text),
              SizedBox(width: ThemeAppSize.kInterval5),
              Icon(item.icon, color: context.theme.hintColor),
            ],
          )),
    );
  }
}

void sortByMass(text) {
  customShowDialog(
    radius: ThemeAppSize.kRadius18,
    widget: Container(
      height: Get.context!.height / 1.5,
      padding: EdgeInsets.symmetric(horizontal: ThemeAppSize.kInterval24),
      child: text == 'Sort by'
          ? const FilterItemSortByBody()
          : FilterItemFilterBody(),
    ),
  );
}

class FilterItemSortByBody extends StatelessWidget {
  const FilterItemSortByBody({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: ThemeAppSize.kInterval12),
        Center(
            child: BigText(
          text: 'sort by',
          size: ThemeAppSize.kFontSize20 * 1.3,
        )),
        SizedBox(height: ThemeAppSize.kInterval5),
        const Divider(),
        const BigText(text: 'Price'),
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
        SizedBox(height: ThemeAppSize.kInterval5),
        const Divider(),
        const BigText(text: 'Name'),
        _TitleSort(
          text: 'A to Z',
          value: SortMethod.aToZ,
          icon: Icons.arrow_circle_up,
        ),
        _TitleSort(
          text: 'Z to A',
          value: SortMethod.zToA,
          icon: Icons.arrow_circle_down,
        ),
      ],
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
      contentPadding: EdgeInsets.symmetric(
        horizontal: ThemeAppSize.kInterval12,
      ),
      horizontalTitleGap: ThemeAppSize.kInterval12,
      minVerticalPadding: ThemeAppSize.kInterval12,
      minLeadingWidth: ThemeAppSize.kInterval12,
      title: BigText(text: text),
      trailing: Icon(icon, color: context.theme.hintColor),
      leading: GetBuilder<MenuController>(
        builder: (_) {
          return Radio(
            activeColor: context.theme.primaryColor,
            value: value,
            groupValue: controller.method,
            onChanged: (SortMethod? valueMethod) =>
                controller.setMethod(valueMethod),
          );
        },
      ),
    );
  }
}

class FilterItemFilterBody extends StatelessWidget {
  FilterItemFilterBody({super.key});
  final init = Get.find<MenuController>().initFilterValue();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MenuController>(
      builder: (menuController) {
        final minV = menuController.filterValue.start.round().toString();
        final maxV = menuController.filterValue.end.round().toString();
        return Row(
          children: [
            SmallText(text: minV),
            Expanded(
                child: RangeSlider(
              activeColor: Colors.red[700],
              inactiveColor: Colors.red[300],
              min: menuController.listPrice.reduce(min),
              max: menuController.listPrice.reduce(max),
              values: menuController.filterValue,
              onChanged: (RangeValues values) =>
                  menuController.onChangedFilter(values),
            )),
            SmallText(text: maxV),
          ],
        );
      },
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
          widget1: Icon(Icons.grid_view, color: context.theme.hintColor),
          widget2: Icon(Icons.list, color: context.theme.hintColor),
        );
      },
    );
  }
}
