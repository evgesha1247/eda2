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
  final List _icon = <IconData>[Icons.height_sharp, Icons.filter_list_outlined];
  final List _text = <String>['Sort by', 'Filter'];

  Widget titleSortItem({
    required SortMethod value,
    required String text,
    required IconData icon,
  }) {
    return ListTile(
      title: SmallText(
        text: text,
        color: ThemeAppColor.kFrontColor,
        size: ThemeAppSize.kFontSize20,
      ),
      subtitle: const SmallText(
        text: 'Price',
        color: ThemeAppColor.kFrontColor,
        size: 14,
      ),
      trailing: Icon(icon),
      leading: Radio(
        activeColor: ThemeAppColor.kAccent,
        value: value,
        groupValue: controller.method,
        onChanged: (SortMethod? valueMethod) =>
            controller.setMethod(valueMethod),
      ),
    );
  }

  void mass() {
    Get.defaultDialog(
      title: 'Sort by',
      titlePadding: EdgeInsets.only(top: ThemeAppSize.kInterval24),
      titleStyle: const TextStyle(color: ThemeAppColor.kFrontColor),
      backgroundColor: ThemeAppColor.kBGColor,
      radius: ThemeAppSize.kRadius12,
      content: GetBuilder<MenuController>(
        builder: (_) {
          return Column(
            children: [
              titleSortItem(
                text: 'low to high',
                value: SortMethod.lowToHigh,
                icon: Icons.arrow_circle_up,
              ),
              titleSortItem(
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
          color: ThemeAppColor.kFrontColor,
          borderRadius: BorderRadius.all(
            Radius.circular(
              ThemeAppSize.kRadius12,
            ),
          ),
        ),
      ),
    );
  }


  Widget _buttonTogListWidget() {
    return GetBuilder<MenuController>(
      builder: (controller) {
        return AnimatedIconWidget(
          currIndex: (controller.isListGrid ? 0 : 1).obs,
          fun: () => controller.togStatusList(),
          widget1: const CustomButtonIcon(child: Icon(Icons.grid_view)),
          widget2: const CustomButtonIcon(child: Icon(Icons.list)),
        );
      },
    );
  }

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
            _buttonTogListWidget(),
            Wrap(
              spacing: ThemeAppSize.kInterval12,
              children: List.generate(
                _text.length,
                (index) {
                  return GestureDetector(
                    onTap: () => mass(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: ThemeAppColor.kFrontColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            ThemeAppSize.kRadius12,
                          ),
                        ),
                      ),
                      child: CustomButtonIcon(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: ThemeAppSize.kInterval12,
                          ),
                          child: Wrap(
                            children: [
                              SmallText(
                                text: _text[index],
                                color: ThemeAppColor.kBGColor,
                              ),
                              Icon(
                                _icon[index],
                                color: ThemeAppColor.kBGColor,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),

            ),
          ],
        ),
      ),
    );
  }
}
