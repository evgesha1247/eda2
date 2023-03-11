import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/auth_controller.dart';
import '../../../../theme/theme_app.dart';
import '../../../../widgets/icon/anumated_icon.dart';
import '../../../../widgets/text/my_text.dart';
import '../profile_page.dart';

class ProfileSetting extends StatelessWidget {
  const ProfileSetting({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(ThemeAppSize.kInterval12),
      child: Column(
        children: [
          _TitleSetting(title: 'setting'.tr),
          _SettingBody(),
          _ButtonSave(),
        ],
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
        const ToggLanguage(),
        const Spacer(),
        BigText(text: title),
        const Spacer(),
        const _ButtonClose(),
      ],
    );
  }
}



class _SettingBody extends StatelessWidget {
  _SettingBody();
  final _ = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    final List cTextField = [_.cName, _.cPhone, _.cAddress, _.cPhotoURL];
    final List cTitle = [
      'name'.tr,
      'phone'.tr,
      'address'.tr,
      '${'photo'.tr} ( URL )'
    ];
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        children: List.generate(
          cTextField.length,
          (index) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SmallText(text: cTitle[index]),
              _TextFieldItem(
                  controller: cTextField[index], text: cTitle[index]),
              SizedBox(height: ThemeAppSize.kInterval12),
            ],
          ),
        ),
      ),
    );
  }
}

class _TextFieldItem extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  const _TextFieldItem({this.text = '', required this.controller});
  @override
  Widget build(BuildContext context) {
    final style = OutlineInputBorder(
      borderSide: BorderSide(color: context.theme.hintColor),
    );
    return TextField(
      maxLines: 10,
      minLines: 1,
      controller: controller,
      cursorColor: context.theme.primaryColor,
      keyboardType: text == 'Phone' ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        isDense: true,
        hintText: controller.text,
        prefixIcon: Icon(Icons.edit, color: context.theme.hintColor),
        border: style,
        focusedBorder: style,
      ),
    );
  }
}

class _ButtonSave extends StatelessWidget {
  _ButtonSave();
  final controller = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
            child: MyButtonString(text: 'save'.tr),
            onTap: () => controller.saveUpData()),
      ],
    );
  }
}

class _ButtonClose extends StatelessWidget {
  const _ButtonClose();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: const Icon(Icons.close),
      onTap: () => Get.back(),
    );
  }
}
