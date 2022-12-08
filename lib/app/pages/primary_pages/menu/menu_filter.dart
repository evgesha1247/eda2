import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/menu_controller.dart';
import '../../../theme/theme_app.dart';
import '../../../widgets/icon/anumated_icon_favorit.dart';
import '../../../widgets/icon/custom_icon.dart';
import '../../../widgets/text/my_text.dart';

class FilterWidget extends StatelessWidget {
  FilterWidget({super.key});
  final controller = Get.find<MenuController>();
  @override

  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(
          left: ThemeAppSize.kInterval12,
          bottom: ThemeAppSize.kInterval12,
        ),
        child: Row(
          children: [
            const _ButtonTogList(),
            Wrap(
              spacing: ThemeAppSize.kInterval12,
              children: controller.listFilterItems,
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
      title: SmallText(
        text: text,
        //color: Get.theme.backgroundColor,
        size: ThemeAppSize.kFontSize20,
      ),
      subtitle: SmallText(
        text: 'Price',
        //color: Get.theme.backgroundColor,
        size: 14,
      ),
      trailing: Icon(icon),
      leading: Radio(
        activeColor: Get.theme.primaryColor,
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
      titleStyle: TextStyle(//color: Get.theme.backgroundColor
          ),
      backgroundColor: Get.theme.cardColor,
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
          //color: Get.theme.backgroundColor,
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
          //color: Get.theme.backgroundColor,
          borderRadius: BorderRadius.all(
            Radius.circular(ThemeAppSize.kRadius12),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(ThemeAppSize.kInterval12),
          child: Wrap(
            children: [
              SmallText(
                text: text, //color: Get.theme.cardColor
              ),
              Icon(
                icon, //color: Get.theme.cardColor
              ),
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
          currIndex: (controller.isListGrid ? 0 : 1).obs,
          fun: () => controller.togStatusList(),
          widget1: const WrapperIcon(child: Icon(Icons.grid_view)),
          widget2: const WrapperIcon(child: Icon(Icons.list)),
        );
      },
    );
  }
}
