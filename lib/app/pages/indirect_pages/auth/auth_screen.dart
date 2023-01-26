// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../theme/theme_app.dart';
import '../../../widgets/icon/anumated_icon_favorit.dart';
import '../../../widgets/text/my_text.dart';
import '../../../controllers/auth_controller.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(ThemeAppSize.kInterval12),
        child: Column(
          children: [
            Stack(
              children: const [
                Center(child: _AuthImg()),
                Align(
                  alignment: Alignment.centerRight,
                  child: ToggLanguage(),
                ),
              ],
            ),
            SizedBox(height: ThemeAppSize.kInterval24),
            Expanded(
                child: ListView(shrinkWrap: true, children: [
              _AuthBody(),
              SizedBox(height: ThemeAppSize.kInterval24),
              _ToggLog(),
              // const Spacer(),
              _AuthButtonSubmit(),
            ])),
          ],
        ),
      ),
    );
  }
}

class _AuthImg extends StatelessWidget {
  const _AuthImg();
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: ThemeAppSize.kInterval24 * 2,
      backgroundColor: context.theme.cardColor,
      child: Icon(
        Icons.person,
        color: context.theme.scaffoldBackgroundColor,
        size: ThemeAppSize.kFontSize20 * 2,
      ),
    );
  }
}

class _AuthBody extends StatelessWidget {
  final controller = Get.put(AuthController());
  _AuthBody();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => controller.isLogScreen
            ? const SizedBox.shrink()
            : Column(
                children: [
                  MyTextField(
                    controller: controller.cName,
                    text: 'Ivan',
                    icon: Icons.person,
                  ),
                  SizedBox(height: ThemeAppSize.kInterval12),
                  MyTextField(
                    controller: controller.cPhone,
                    text: 'Phone',
                    icon: Icons.phone,
                  ),
                  SizedBox(height: ThemeAppSize.kInterval12),
                  MyTextField(
                    controller: controller.cPhotoURL,
                    text: 'img URL',
                    icon: Icons.image,
                  ),
                  SizedBox(height: ThemeAppSize.kInterval12),
                ],
              )),
        MyTextField(
          controller: controller.cEmail,
          text: 'Ivan@gmail.com',
          icon: Icons.mail,
        ),
        SizedBox(height: ThemeAppSize.kInterval12),
        MyTextField(
            controller: controller.cPassword,
            text: 'Password',
            icon: Icons.key),
      ],
    );
  }
}

class _AuthButtonSubmit extends StatelessWidget {
  final AuthController controller = Get.find();
  _AuthButtonSubmit();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ThemeAppSize.kInterval12),
      child: Obx(() => InkWell(
            onTap: () => controller.authUser(),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: ThemeAppSize.kInterval24,
                vertical: ThemeAppSize.kInterval12,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(ThemeAppSize.kRadius12),
                ),
                border: Border.all(
                  color: context.theme.cardColor,
                  width: 2,
                ),
              ),
              child: Center(child: BigText(text: controller.buttonText)),
            ),
          )),
    );
  }
}

class _ToggLog extends StatelessWidget {
  final AuthController controller = Get.find();
  _ToggLog();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => controller.togScreenAuth(),
      child: Center(
        child: Obx(() => BigText(
              text: controller.isLogScreen
                  ? 'no_accaount'.tr
                  : 'have_an_account'.tr,
              color: context.theme.hintColor,
            )),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    this.icon,
    required this.controller,
    required this.text,
  });
  final TextEditingController controller;
  final String text;
  final dynamic icon;
  @override
  Widget build(BuildContext context) {
    RxBool status = text == 'Password' ? false.obs : true.obs;
    return Material(
      elevation: 5,
      color: context.theme.cardColor,
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.all(
        Radius.circular(ThemeAppSize.kRadius12),
      ),
      child: Obx(
        () => TextField(
          onSubmitted: (_) => FocusScope.of(context).nextFocus(),
          controller: controller,
          obscureText: !status.value,
          textInputAction: TextInputAction.next,
          cursorColor: context.theme.accentColor,
          keyboardType:
              text == 'Phone' ? TextInputType.number : TextInputType.text,
          decoration: InputDecoration(
            hintStyle: TextStyle(color: context.theme.accentColor),
            hintText: text,
            suffixIcon: text == 'Password'
                ? GestureDetector(
                    onTap: () => status.value = !status.value,
                    child: Icon(
                      status.value
                          ? Icons.visibility_rounded
                          : Icons.visibility_off_rounded,
                      color: context.theme.accentColor,
                    ),
                  )
                : null,
            prefixIcon: icon != null
                ? Icon(icon, color: context.theme.accentColor)
                : null,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
