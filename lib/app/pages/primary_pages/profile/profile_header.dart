import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../../theme/theme_app.dart';
import '../../../theme/theme_controller.dart';
import '../../../widgets/button/my_button.dart';
import '../../../widgets/icon/anumated_icon_favorit.dart';
import '../../../widgets/text/my_text.dart';

class ProfileHeader extends StatelessWidget {
  ProfileHeader({super.key});
  final controller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: ThemeAppSize.kHeight75),
          child: const _BGCoverImg(),
        ),
        Positioned(
          top: (ThemeAppSize.kHeight100 * 2) -
              ThemeAppSize.kHeight75 -
              ThemeAppSize.kInterval12,
          child: _ProfileImg(),
        ),
      ],
    );
  }
}

class _BGCoverImg extends StatelessWidget {
  const _BGCoverImg();
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(ThemeAppSize.kRadius18 * 2))),
          child: Image.network(
            width: double.infinity,
            height: ThemeAppSize.kHeight100 * 2,
            fit: BoxFit.cover,
            'https://sun9-88.userapi.com/impg/jTS8KhO9zKlRak-GhweWQkF6ZVVEcSRiRbi7TA/Br1eQOIe7l4.jpg?size=604x340&quality=95&sign=3c6928c27d1c115a36d16b2b2a597616&type=album',
          ),
        ),
        Padding(
          padding: EdgeInsets.all(ThemeAppSize.kInterval12),
          child: GestureDetector(
            onTap: () => _inputDialog(),
            child: Icon(
              Icons.settings,
              color: Get.context?.theme.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}

class _ProfileImg extends StatelessWidget {
  _ProfileImg();
  final controller = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: ThemeAppSize.kHeight75 + ThemeAppSize.kInterval12,
      backgroundColor: context.theme.scaffoldBackgroundColor,
      child: CircleAvatar(
        radius: ThemeAppSize.kHeight75,
        backgroundColor: Colors.grey,
        backgroundImage: NetworkImage(controller.user.value?.photoURL ??
            'https://sun9-37.userapi.com/impg/2wacFjjPgzxCl62bPdXcMqaJVygy7Tc-aHqzRg/FKl9lTUpMwQ.jpg?size=338x320&quality=96&sign=21d97efc03d3a0b2e1a1a17fc46a0408&type=album'),
      ),
    );
  }
}

/////// dialog setting //////
Future _inputDialog() async {
  return showDialog(
    context: Get.context!,
    builder: (BuildContext context) {
      return Dialog(
          backgroundColor: context.theme.scaffoldBackgroundColor,
          alignment: Alignment.bottomCenter,
          insetPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(ThemeAppSize.kRadius12),
            ),
          ),
          child: const _SettingBody());
    },
  );
}

class _SettingBody extends StatelessWidget {
  const _SettingBody();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ThemeAppSize.kInterval12),
      height: ThemeAppSize.height / 1.5,
      child: Column(
        children: [
          const _SettingThemeIcon(),
          SizedBox(height: ThemeAppSize.kInterval12),
          const Center(child: BigText(text: 'Setting')),
          SizedBox(height: ThemeAppSize.kInterval12),
          const _SettingTextFields(),
          SizedBox(height: ThemeAppSize.kInterval12),
          const _DialogButtons(),
        ],
      ),
    );
  }
}

class _SettingTextFields extends StatelessWidget {
  const _SettingTextFields();
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        const _TextFieldItem(text: 'name'),
        SizedBox(height: ThemeAppSize.kInterval12),
        const _TextFieldItem(text: 'phone'),
        SizedBox(height: ThemeAppSize.kInterval12),
        const _TextFieldItem(text: 'addres'),
      ],
    );
  }
}

class _TextFieldItem extends StatelessWidget {
  final String text;
  const _TextFieldItem({required this.text});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.theme.scaffoldBackgroundColor,
      elevation: 3,
      child: TextField(
        decoration: InputDecoration(
          labelStyle: TextStyle(color: context.theme.cardColor),
          isDense: true,
          fillColor: context.theme.cardColor,
          prefixIcon: const Icon(Icons.edit),
          label: SmallText(text: text),
          border: const OutlineInputBorder(),
          contentPadding: EdgeInsets.all(
            ThemeAppSize.kInterval12,
          ),
        ),
      ),
    );
  }
}

class _SettingThemeIcon extends StatelessWidget {
  const _SettingThemeIcon();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeAppController>(
      builder: (_) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SmallText(
              text: _.isLightTheme ? 'to dark ' : 'to light ',
            ),
            SizedBox(
              width: 30,
              height: 30,
              child: AnimatedIconWidget(
                currIndex: (_.isLightTheme ? 0 : 1).obs,
                fun: () => _.tooggTheme(),
                widget1: Image(
                  color: Get.context?.theme.cardColor,
                  image: const AssetImage("assets/icons/tog_theme.png"),
                ),
                widget2: Image(
                  color: Get.context?.theme.accentColor,
                  image: const AssetImage("assets/icons/tog_theme.png"),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _DialogButtons extends StatelessWidget {
  const _DialogButtons();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const InkWell(
          child: MyButtonString(text: 'save'),
          //  onTap: () => controller.setUserName(name : )
        ),
        SizedBox(width: ThemeAppSize.kInterval12),
        InkWell(
          child: const MyButtonString(text: 'back'),
          onTap: () => Get.back(),
        ),
      ],
    );
  }
}
