import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/theme/theme_app.dart';

import '../controller/menu_controller.dart';
import '../../../../widgets/text/my_text.dart';
import '../model/filter_model.dart';

class FilterSortBy extends StatelessWidget {
  final Widget widgetTitle;
  const FilterSortBy({super.key, required this.widgetTitle});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widgetTitle,
        const Divider(),
        BigText(text: 'price'.tr),
        _ListTitleSort(
          text: 'low_to_high'.tr,
          value: SortMethod.lowToHigh,
          icon: Icons.arrow_circle_up,
        ),
        _ListTitleSort(
          text: 'high_to_low'.tr,
          value: SortMethod.highToLow,
          icon: Icons.arrow_circle_down,
        ),
        SizedBox(height: ThemeAppSize.kInterval5),
        const Divider(),
        BigText(text: 'name'.tr),
        _ListTitleSort(
          text: 'A_to_Z'.tr,
          value: SortMethod.aToZ,
          icon: Icons.arrow_circle_up,
        ),
        _ListTitleSort(
          text: 'Z_to_A'.tr,
          value: SortMethod.zToA,
          icon: Icons.arrow_circle_down,
        ),
      ],
    );
  }
}

class _ListTitleSort extends StatelessWidget {
  final SortMethod value;
  final String text;
  final IconData icon;
  _ListTitleSort({
    required this.value,
    required this.text,
    required this.icon,
  });
  final controller = Get.find<MenuControll>();
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
      leading: GetBuilder<MenuControll>(
        builder: (_) {
          return Radio<SortMethod>(
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
