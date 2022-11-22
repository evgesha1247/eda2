import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/theme_app.dart';
import '../../widgets/text/my_text.dart';
import '../../widgets/text_field/my_submit_button.dart';
import '../../widgets/text_field/my_text_field.dart';
import 'auth_model.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(ThemeAppSize.kInterval24),
        child: Column(
          children: [
            _AuthBody(),
            _AuthButtonSubmit(),
            _ToggScreenTextWidget(),
          ],
        ),
      ),
    );
  }
}

class _AuthBody extends StatelessWidget {
  final controller = Get.put(AuthModel());
  _AuthBody();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => controller.isLogScreen
            ? const SizedBox.shrink()
            : MyTextField(
                controller: controller.cName,
                text: 'Ivan',
                icon: Icons.person,
              )),
        SizedBox(height: ThemeAppSize.kInterval12),
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
  final AuthModel controller = Get.find();
  _AuthButtonSubmit();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ThemeAppSize.kInterval12),
      child: Obx(() => MySubmitButton(
          fun: () => controller.authUser(
                email: controller.cEmail.text,
                pass: controller.cPassword.text,
              ),
          text: controller.buttonText)),
    );
  }
}

class _ToggScreenTextWidget extends StatelessWidget {
  final AuthModel controller = Get.find();
  _ToggScreenTextWidget();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => controller.togScreenAuth(),
      child: const BigText(
        text: 'adafadf',
        color: ThemeAppColor.kFrontColor,
      ),
    );
  }
}
