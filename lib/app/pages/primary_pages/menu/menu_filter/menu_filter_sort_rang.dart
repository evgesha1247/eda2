import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/widgets/text/my_text.dart';
import '../controller/menu_controller.dart';
import '../../../../theme/theme_app.dart';

class SortRangFilterMenu extends StatelessWidget {
  final Widget widgetTitle;
  SortRangFilterMenu({super.key, required this.widgetTitle});
  final init = Get.find<MenuControll>().initFilterValue();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widgetTitle,
        const Divider(),
        const PriceSliderSortRangFilterMenu(),
        const Divider(),
        const CategorySortRangFilterMenu(),
        const Divider(),
      ],
    );
  }
}

class PriceSliderSortRangFilterMenu extends StatelessWidget {
  const PriceSliderSortRangFilterMenu({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MenuControll>(
      builder: (menuController) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: ThemeAppSize.kInterval5),
            Row(
              children: [
                SmallText(text: 'price_range'.tr),
                const Spacer(),
                SmallText(text: menuController.priceRange),
              ],
            ),
            SliderTheme(
              data: const SliderThemeData(trackHeight: 0.5),
              //color: Colors.red,
              child: RangeSlider(
                activeColor: context.theme.primaryColor,
                inactiveColor: context.theme.cardColor,
                min: menuController.listPrice.reduce(min),
                max: menuController.listPrice.reduce(max),
                values: menuController.filterValue,
                onChanged: (RangeValues values) => menuController.onChangedFilter(values),
              ),
            ),
          ],
        );
      },
    );
  }
}

class CategorySortRangFilterMenu extends StatelessWidget {
  const CategorySortRangFilterMenu({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: ThemeAppSize.kInterval5),
          SmallText(text: 'category'.tr),
          SizedBox(height: ThemeAppSize.kInterval12),
          const _ItemsBuild(),
        ],
      ),
    );
  }
}

class _ItemsBuild extends StatelessWidget {
  const _ItemsBuild();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MenuControll>(
      builder: (controller) => SizedBox(
        width: double.infinity,
        child: Wrap(
          spacing: ThemeAppSize.kInterval12,
          runSpacing: ThemeAppSize.kInterval12,
          children: List.generate(
            controller.mapCategory.length,
            (index) => FilterChip(
              label: BigText(
                text: controller.mapCategory.keys.toList()[index],
                color: controller.mapCategory.values.toList()[index]
                    ? ThemeAppColor.kBGColor
                    : ThemeAppColor.kBGColor.withOpacity(0.5),
              ),
              labelPadding: EdgeInsets.symmetric(
                horizontal: ThemeAppSize.kInterval24,
                vertical: ThemeAppSize.kInterval5 / 2,
              ),
              selectedColor: context.theme.cardColor,
              backgroundColor: context.theme.cardColor,
              checkmarkColor: ThemeAppColor.kBGColor,
              selected: controller.mapCategory.values.toList()[index],
              onSelected: (bool value) => controller.onSelectChip(
                  value, controller.mapCategory.keys.toList()[index]),
            ),
          ),
        ),
      ),
    );
  }
}