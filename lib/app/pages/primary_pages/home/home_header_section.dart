import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/pages/primary_pages/guiding/guiding_controller.dart';
import '../../../routes/main_routes.dart';
import '../../../theme/theme_app.dart';
import '../../../widgets/icon/custom_icon.dart';
import '../../../widgets/text/my_text.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(ThemeAppSize.kInterval12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          _UserTitle(),
          ButtonIconCart(),
        ],
      ),
    );
  }
}

class _UserTitle extends StatelessWidget {
  const _UserTitle();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const _UserIcon(),
        SizedBox(width: ThemeAppSize.kInterval12),
        const BigText(text: 'Welcom'),
        SizedBox(width: ThemeAppSize.kInterval5),
        Icon(
          Icons.grid_3x3,
          size: ThemeAppSize.kFontSize18,
          color: context.theme.hintColor,
        ),
        BigText(
          text: '{name}',
          size: ThemeAppSize.kFontSize18
        ),
      ],
    );
  }
}

class _UserIcon extends StatelessWidget {
  const _UserIcon();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.find<GuidingController>().setCurrentIndexTab(3),
      child: WrapperIcon(
        statusBorder: true,
        colorBorder: context.theme.hintColor,
        child: Icon(
          Icons.person_outline,
          color: context.theme.hintColor,
          size: ThemeAppSize.kFontSize20,
        ),
      ),
    );
  }
}
