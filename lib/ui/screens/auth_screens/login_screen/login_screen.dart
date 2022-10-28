import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/ui/screens/auth_screens/login_screen/login_controller.dart';
import 'package:text/ui/screens/auth_screens/register_screen/register_screen.dart';
import 'package:text/ui/widgets/text/small_text.dart';

import '../../../theme/theme_app.dart';
import '../../../widgets/text/big_text.dart';
import '../../../widgets/text_field/my_auth_button.dart';
import '../../../widgets/text_field/my_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(ThemeAppSize.kInterval24),
        child: Column(
          children: [
            const _LoginBody(),
            SizedBox(height: ThemeAppSize.kInterval24),
            const _LoginToRegister(),
            SizedBox(height: ThemeAppSize.kInterval24),
          ],
        ),
      ),
    );
  }
}

class _LoginBody extends StatelessWidget {
  const _LoginBody();
  @override
  Widget build(BuildContext context) {
    final constroller = Get.put(LoginController());
    return Column(
      children: [
        myTextField(
          controller: constroller.cEmail,
          text: 'Ivan@gmail.com',
          icon: Icons.mail,
          textInputAction: TextInputAction.next,
          onSubmitted: (_) => FocusScope.of(context).nextFocus(),
        ),
        SizedBox(height: ThemeAppSize.kInterval24),
        myTextField(
          controller: constroller.cPassword,
          text: 'Password',
          icon: Icons.key,
          textInputAction: TextInputAction.next,
          onSubmitted: (_) => FocusScope.of(context).nextFocus(),
        ),
        SizedBox(height: ThemeAppSize.kInterval24),
        myAuthButton(() {
          LoginController.instance.loginUser(
            email: constroller.cEmail.text,
            pass: constroller.cPassword.text,
          );
        }, 'Login')
      ],
    );
  }
}

class _LoginToRegister extends StatelessWidget {
  const _LoginToRegister();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SmallText(
          text: 'wwwerw',
          color: ThemeAppColor.kFrontColor,
        ),
        SizedBox(width: ThemeAppSize.kInterval12),
        InkWell(
          onTap: () => Get.offAll(() => const RegisterScreen()),
          child: const BigText(
            text: 'adafadf ? ',
            color: ThemeAppColor.kFrontColor,
          ),
        ),
      ],
    );
  }
}
