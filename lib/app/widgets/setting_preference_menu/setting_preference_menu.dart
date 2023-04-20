import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/theme_app.dart';
import '../../theme/theme_controller.dart';
import '../icon/anumated_icon.dart';
import '../text/my_text.dart';

class SettingPreferenceMenu extends StatelessWidget {
  const SettingPreferenceMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ItemPreference(
          title: 'Dark mode'.tr,
          icon: Icons.dark_mode,
          trailing: GetBuilder<ThemeAppController>(
            builder: (_) => Switch(
              activeColor: ThemeAppColor.kTextDark,
              activeTrackColor: context.theme.primaryColor,
              value: !Get.find<ThemeAppController>().isLightTheme,
              onChanged: (bool value) => _.tooggTheme(),
            ),
          ),
        ),
        SizedBox(height: ThemeAppSize.kInterval12),
        _ItemPreference(
          title: 'Language'.tr,
          icon: Icons.language,
          trailing: const ToggLanguage(
            w1: BigText(text: 'Руский', color: ThemeAppColor.kTextDark),
            w2: BigText(text: 'English', color: ThemeAppColor.kTextDark),
          ),
        ),
      ],
    );
  }
}

class _ItemPreference extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget trailing;
  const _ItemPreference({
    required this.title,
    required this.icon,
    required this.trailing,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: ThemeAppFun.decoration(radius: ThemeAppSize.kRadius12),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: ThemeAppSize.kInterval24),
        dense: true,
        horizontalTitleGap: 0,
        leading: Icon(icon, color: ThemeAppColor.kTextDark),
        title: BigText(text: title, color: ThemeAppColor.kTextDark),
        trailing: trailing,
      ),
    );
  }
}
