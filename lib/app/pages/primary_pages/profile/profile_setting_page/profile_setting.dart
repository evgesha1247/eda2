import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/auth_controller.dart';
import '../../../../theme/theme_app.dart';
import '../../../../theme/theme_controller.dart';
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
          const _TitleHeaderSetting(),
          SizedBox(height: ThemeAppSize.kInterval12),
          const _BodySetting(),
        ],
      ),
    );
  }
}

class _TitleHeaderSetting extends StatelessWidget {
  const _TitleHeaderSetting();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          Center(
            child: BigText(text: 'setting'.tr, size: ThemeAppSize.kFontSize20 * 1.3),
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
    );
  }
}

class _BodySetting extends StatelessWidget {
  const _BodySetting();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          const _BodyPreference(),
          SizedBox(height: ThemeAppSize.kInterval12),
          const _BodyAreCommon(),
          const Spacer(),
          const _SaveSetting(),
        ],
      ),
    );
  }
}



class _BodyPreference extends StatelessWidget {
  const _BodyPreference();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TitleHeaderSection(title: 'preference'.tr),
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

class _BodyAreCommon extends StatelessWidget {
  const _BodyAreCommon();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TitleHeaderSection(title: 'are common'.tr),
        const TextFilds(),
      ],
    );
  }
}

class _TitleHeaderSection extends StatelessWidget {
  final String title;
  const _TitleHeaderSection({required this.title});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: ThemeAppSize.kInterval12),
        Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: ThemeAppSize.kFontSize20 * 1.5,
                height: 0,
                color: context.theme.hintColor.withOpacity(0.6),
                letterSpacing: 2,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        SizedBox(height: ThemeAppSize.kInterval12),
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

class TextFilds extends StatelessWidget {
  const TextFilds({super.key});
  @override
  Widget build(BuildContext context) {
    final _ = Get.put(AuthController());
    final List cTextField = [_.cName, _.cPhone, _.cAddress, _.cPhotoURL];
    final List cTitle = ['name'.tr, 'phone'.tr, 'address'.tr, '${'photo'.tr} ( URL )'];
    final style = OutlineInputBorder(
        borderSide: const BorderSide(color: ThemeAppColor.kTextDark),
        borderRadius: BorderRadius.all(Radius.circular(
          ThemeAppSize.kRadius12,
        ))
    );
    Widget itemBuild(controller, text) {
      return TextField(
        maxLines: 10,
        minLines: 1,
        controller: controller,
        cursorColor: context.theme.primaryColor,

        keyboardType: text == 'Phone' ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          isDense: true,
          //     hintText: controller.text ?? 'qwe',
          label: BigText(
            text: text,
            color: context.theme.hintColor,
            size: ThemeAppSize.kFontSize20,
          ),

          hintStyle: const TextStyle(
            color: ThemeAppColor.kTextDark,
          ),
          prefixIcon: const Icon(
            Icons.edit,
            color: ThemeAppColor.kTextDark,
          ),
          border: style,
          focusedBorder: style,
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: ThemeAppFun.decoration(radius: ThemeAppSize.kRadius12),
      ),
      padding: EdgeInsets.all(ThemeAppSize.kInterval24),
      child: ListView(
        shrinkWrap: true,
        children: List.generate(
          cTextField.length,
          (index) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SmallText(
              //   text: cTitle[index],
              //   color: ThemeAppColor.kTextDark,
              // ),
              SizedBox(height: ThemeAppSize.kInterval12),

              itemBuild(cTextField[index], cTitle[index]),
              SizedBox(height: ThemeAppSize.kInterval12),
            ],
          ),
        ),
      ),
    );
  }
}

class _SaveSetting extends StatelessWidget {
  const _SaveSetting();
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    return Row(
      children: [
        InkWell(
          child: MyButtonString(text: 'save'.tr),
          onTap: () => controller.saveUpData(),
        ),
      ],
    );
  }
}
