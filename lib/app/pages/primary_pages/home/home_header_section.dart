import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/main_routes.dart';
import '../../../theme/theme_app.dart';
import '../../../widgets/icon/custom_icon.dart';
import '../../../widgets/text/my_text.dart';
import '../guiding/guiding_model.dart';

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
        _UserIcon(),
        SizedBox(width: ThemeAppSize.kInterval12),
        const BigText(
          text: 'Welcom',
          color: ThemeAppColor.kFrontColor
        ),
        Icon(Icons.grid_3x3, size: ThemeAppSize.kFontSize18),
        BigText(
          text: 'name',
          color: ThemeAppColor.kFrontColor,
          size: ThemeAppSize.kFontSize18,
        ),
      ],
    );
  }
}

class _UserIcon extends StatelessWidget {
  _UserIcon();
  final pageController = Get.find<GuidingScreenModel>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(MainRoutes.getProfile()),
      child: CustomButtonIcon(
        bg: ThemeAppColor.kBGColor,
        statusBorder: true,
        colorBorder: ThemeAppColor.kFrontColor,
        child: Icon(
          Icons.person_outline,
          color: ThemeAppColor.kFrontColor,
          size: ThemeAppSize.kFontSize20,
        ),
      ),
    );
  }
}
