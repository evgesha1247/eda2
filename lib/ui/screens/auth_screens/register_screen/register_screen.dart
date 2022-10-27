import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:text/ui/screens/auth_screens/login_screen/login_screen.dart';
import 'package:text/ui/screens/auth_screens/register_screen/register_controller.dart';

import '../../../theme/theme_app.dart';
import '../../../widgets/text/big_text.dart';
import '../../../widgets/text/small_text.dart';
import '../../../widgets/text_field/my_auth_button.dart';
import '../../../widgets/text_field/my_text_field.dart';
import '../auth_model.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(ThemeAppSize.kInterval24),
        child: Column(
          children: [
            const _RegisterBody(),
            SizedBox(height: ThemeAppSize.kInterval24),
            const _RegisterToLogin(),
            SizedBox(height: ThemeAppSize.kInterval24),
          ],
        ),
      ),
    );
  }
}

class _RegisterBody extends StatelessWidget {
  const _RegisterBody();
  @override
  Widget build(BuildContext context) {
    final constroller = Get.put(RegisterController());
    return Column(
      children: [
        myTextField(
          controller: constroller.cName,
          text: 'Ivan',
          icon: Icons.person,
          textInputAction: TextInputAction.next,
          onSubmitted: (_) => FocusScope.of(context).nextFocus(),
        ),
        SizedBox(height: ThemeAppSize.kInterval24),
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
        myAuthButton(() {
          RegisterController.instance.registerUser(
            email: constroller.cEmail.text,
            pass: constroller.cPassword.text,
          );
        }, 'Register')
      ],
    );
  }
}

class _RegisterToLogin extends StatelessWidget {
  const _RegisterToLogin();
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
            onTap: () => Get.offAll(() => const LoginScreen()),
            child: const BigText(
              text: 'adafadf ? ',
              color: ThemeAppColor.kFrontColor,
            )),
      ],
    );
  }
}
