import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../theme/theme_app.dart';
import '../../../widgets/icon/wrap_icon.dart';
import '../../../widgets/setting_preference_menu/setting_preference_menu.dart';
import '../../../widgets/show_dialog/custom_show_dialog.dart';
import '../../../widgets/text/my_text.dart';

class HeaderAuth extends StatelessWidget {
  const HeaderAuth({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        const BigText(text: 'Страница авторизации'),
        Align(
          alignment: Alignment.topRight,
          child: InkWell(
            onTap: () => customShowDialog(
              widget: const _SettingBody(),
              radius: ThemeAppSize.kRadius18,
            ),
            child: WrapperIcon(
              colorBorder: context.theme.hintColor,
              bg: context.theme.scaffoldBackgroundColor,
              icon:
                Icons.settings,

            ),
          ),
        ),
      ],
    );
  }
}

class _SettingBody extends StatelessWidget {
  const _SettingBody();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(ThemeAppSize.kInterval24),
      child: Wrap(
        runSpacing: ThemeAppSize.kInterval24,
        children: [
          Stack(
            children: [
              Center(
                child: BigText(
                  text: 'setting'.tr,
                  size: ThemeAppSize.kFontSize20 * 1.3,
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  child: Icon(Icons.close, color: context.theme.hintColor),
                  onTap: () => Get.back(),
                ),
              ),
            ],
          ),
          SizedBox(height: ThemeAppSize.kInterval24),
          const SettingPreferenceMenu(),
        ],
      ),
    );
  }
}
