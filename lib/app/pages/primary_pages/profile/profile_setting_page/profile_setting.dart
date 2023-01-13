import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/auth_controller.dart';
import '../../../../theme/theme_app.dart';
import '../../../../widgets/text/my_text.dart';

class ProfileSetting extends StatelessWidget {
  const ProfileSetting({super.key});
  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      children: Get.find<AuthController>().user != null
          ? [
              //    const _SettingThemeIcon(),
              SizedBox(height: ThemeAppSize.kInterval12),
              const Center(child: BigText(text: 'Setting')),
              SizedBox(height: ThemeAppSize.kInterval12),
              _SettingTextFields(),
              SizedBox(height: ThemeAppSize.kInterval12),
              //  _DialogButtons(),
            ]
          : [
              //    const _SettingThemeIcon(),
              const Spacer(),
              SmallText(
                text: 'Sorry , user not registered',
                size: ThemeAppSize.kFontSize20,
              ),
              const Spacer(),
            ],
    );
  }
}

class _SettingTextFields extends StatelessWidget {
  _SettingTextFields();
  final controller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        _TextFieldItem(controller: controller.cSettingName),
        SizedBox(height: ThemeAppSize.kInterval12),
        _TextFieldItem(controller: controller.cSettingPhone),
        SizedBox(height: ThemeAppSize.kInterval12),
        _TextFieldItem(controller: controller.cSettingPhotoURL),
      ],
    );
  }
}

class _TextFieldItem extends StatelessWidget {
  final TextEditingController controller;
  const _TextFieldItem({required this.controller});
  @override
  Widget build(BuildContext context) {
    final style = OutlineInputBorder(
      borderSide: BorderSide(color: context.theme.hintColor),
    );
    return Card(
      color: context.theme.scaffoldBackgroundColor,
      clipBehavior: Clip.hardEdge,
      elevation: 3,
      child: TextField(
        minLines: 1,
        maxLines: null,
        controller: controller,
        cursorColor: context.theme.primaryColor,
        decoration: InputDecoration(
          isDense: true,
          prefixIcon: Icon(Icons.edit, color: context.theme.hintColor),
          hintText: controller.text,
          hintStyle: TextStyle(color: context.theme.primaryColor),
          border: style,
          focusedBorder: style,
          contentPadding: EdgeInsets.all(
            ThemeAppSize.kInterval12,
          ),
        ),
      ),
    );
  }
}


// class _DialogButtons extends StatelessWidget {
//   _DialogButtons();
//   final controller = Get.find<AuthController>();
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         InkWell(
//           child: const MyButtonString(text: 'save'),
//           onTap: () => controller.setUserName(),
//         ),
//         SizedBox(width: ThemeAppSize.kInterval12),
//         InkWell(
//           child: const MyButtonString(text: 'back'),
//           onTap: () => Get.back(),
//         ),
//       ],
//     );
//   }
// }
