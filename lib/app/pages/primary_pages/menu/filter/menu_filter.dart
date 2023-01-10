import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../theme/theme_app.dart';
import '../../../../widgets/icon/anumated_icon_favorit.dart';
import '../../../../widgets/show_dialog/custom_show_dialog.dart';
import '../../../../widgets/text/my_text.dart';
import '../model/filter_model.dart';
import 'filter_rang.dart';
import 'filter_sort_by.dart';

const List<FilterModel> filterModel = [
  FilterModel(text: 'Sort by', icon: Icons.short_text_outlined),
  FilterModel(text: 'Filter', icon: Icons.filter_alt_outlined),
];

class MenuFilter extends StatelessWidget {
  const MenuFilter({super.key});
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          SizedBox(width: ThemeAppSize.kInterval12),
          const ButtonTogList(),
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
  final FilterModel item;
  const _FilterItem({required this.item});
  void sortByMass(text) {
    customShowDialog(
      radius: ThemeAppSize.kRadius18,
      widget: Container(
        height: Get.context!.height / 1.5,
        padding: EdgeInsets.symmetric(horizontal: ThemeAppSize.kInterval24),
        child: text == 'Sort by'
            ? FilterSortBy(widgetTitle: _FilterTitle(title: text))
            : FilterRang(widgetTitle: _FilterTitle(title: text)),
      ),
    );
  }

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
        ),
      ),
    );
  }
}

class _FilterTitle extends StatelessWidget {
  final String title;
  const _FilterTitle({required this.title});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: ThemeAppSize.kInterval12),
        Center(
            child: BigText(
          text: title,
          size: ThemeAppSize.kFontSize20 * 1.3,
        )),
        SizedBox(height: ThemeAppSize.kInterval5),
      ],
    );
  }
}