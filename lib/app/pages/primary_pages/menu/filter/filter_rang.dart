import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/widgets/text/my_text.dart';
import '../controller/menu_controller.dart';
import '../../../../theme/theme_app.dart';

class FilterRang extends StatelessWidget {
  final Widget widgetTitle;
  FilterRang({super.key, required this.widgetTitle});
  final init = Get.find<MenuController>().initFilterValue();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widgetTitle,
        const Divider(),
        const PriceRangeSlider(),
        const Divider(),
        CategoryList(),
        const Divider(),
      ],
    );
  }
}

class PriceRangeSlider extends StatelessWidget {
  const PriceRangeSlider({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MenuController>(
      builder: (menuController) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: ThemeAppSize.kInterval5),
            Row(
              children: [
                const SmallText(text: 'Price range'),
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
                onChanged: (RangeValues values) =>
                    menuController.onChangedFilter(values),
              ),
            ),
          ],
        );
      },
    );
  }
}

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: ThemeAppSize.kInterval5),
          const SmallText(text: 'Category'),
          SizedBox(height: ThemeAppSize.kInterval12),
          _ItemsBuild(),
        ],
      ),
    );
  }
}

class _ItemsBuild extends StatelessWidget {
  _ItemsBuild();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MenuController>(
      builder: (controller) => Wrap(
        children: List.generate(
          controller.mapCategory.length,
          (index) => FilterChip(
            label: Text(controller.mapCategory.keys.toList()[index]),
            labelPadding:
                EdgeInsets.symmetric(horizontal: ThemeAppSize.kInterval12),
            selectedColor: Colors.purple,
            selected: controller.mapCategory.values.toList()[index],
            onSelected: (bool value) => controller.onSelectChip(
                value, controller.mapCategory.keys.toList()[index]),
          ),
        ),
      ),
    );
  }
}