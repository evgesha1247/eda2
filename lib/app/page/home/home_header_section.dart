import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/theme_app.dart';
import '../../widgets/icon/cart_icon.dart';
import '../../widgets/icon/menu_icon.dart';
import '../../widgets/text/my_text.dart';
import '../guiding/guiding_model.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(ThemeAppSize.kInterval12),
      child: Row(
        children: const [
          _UserTitle(),
          Spacer(),
          CartIcon(),
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
        BigText(
          text: 'Welcom {name}',
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
      onTap: () => pageController.setCurrentIndexTab(3),
      child: const CircleAvatar(
        radius: 22,
        backgroundColor: Colors.transparent,
        child: CustomButtonIcon(
          icon: Icon(
            Icons.person_outline,
            color: ThemeAppColor.kFrontColor
          ),
          bg: ThemeAppColor.kFrontColor,
          statusBorder: true,
        ),
      ),
    );
  }
}
