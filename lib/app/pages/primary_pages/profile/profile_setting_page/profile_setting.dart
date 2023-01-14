import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/auth_controller.dart';
import '../../../../theme/theme_app.dart';
import '../../../../widgets/text/my_text.dart';
import '../profile_page.dart';

class ProfileSetting extends StatelessWidget {
  const ProfileSetting({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(ThemeAppSize.kInterval12),
      child: ListView(scrollDirection: Axis.vertical, children:
              // Get.find<AuthController>().user == null
              //     ?
              [
        const _TitleSetting(title: 'Setting'),
        _SettingTextFields(),
        _DialogButtonSave(),
      ]
          // : [
          //     SmallText(
          //       text: 'Sorry , user not registered',
          //       size: ThemeAppSize.kFontSize20,
          //     ),
          //   ],
          ),
    );
  }
}

class _TitleSetting extends StatelessWidget {
  final String title;
  const _TitleSetting({required this.title});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(),
        const Spacer(),
        BigText(text: title),
        const Spacer(),
        _DialogButtonClose(),
      ],
    );
  }
}

class _SettingTextFields extends StatelessWidget {
  _SettingTextFields();
  final controller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SmallText(text: 'name'),
        _TextFieldItem(controller: controller.cSettingName),
        SizedBox(height: ThemeAppSize.kInterval12),
        const SmallText(text: 'Phone'),
        _TextFieldItem(controller: controller.cSettingPhone),
        SizedBox(height: ThemeAppSize.kInterval12),
        const SmallText(text: 'Photo ( URL )'),
        _TextFieldItem(controller: controller.cSettingPhotoURL),
        SizedBox(height: ThemeAppSize.kInterval12),
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
    return TextFormField(
      maxLines: null,
      controller: controller,
      cursorColor: context.theme.primaryColor,
      decoration: InputDecoration(
        isDense: true,
        prefixIcon: Icon(Icons.edit, color: context.theme.hintColor),
        border: style,
        focusedBorder: style,
      ),
    );
  }
}

class _DialogButtonSave extends StatelessWidget {
  _DialogButtonSave();
  final controller = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          child: const MyButtonString(text: 'save'),
            onTap: () => controller.saveUpData()
        ),
      ],
    );
  }
}

class _DialogButtonClose extends StatelessWidget {
  _DialogButtonClose();
  final controller = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: const Icon(Icons.close),
      onTap: () => Get.back(),
    );
  }
}
