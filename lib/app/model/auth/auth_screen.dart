import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../theme/theme_app.dart';
import '../../widgets/text/big_text.dart';
import '../../widgets/text/small_text.dart';
import '../../widgets/text_field/my_auth_button.dart';
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
            const _AuthBody(),
            SizedBox(height: ThemeAppSize.kInterval24),
            const _ToggScreenTextWidget(),
            SizedBox(height: ThemeAppSize.kInterval24),
          ],
        ),
      ),
    );
  }
}

class _AuthBody extends GetView<AuthModel> {
  const _AuthBody();
  @override
  Widget build(BuildContext context) {
    final bool isLog = controller.isLogScreen;
    return Column(
      children: [
        isLog
            ? const SizedBox.shrink()
            : myTextField(
                controller: controller.cName,
                text: 'Ivan',
                icon: Icons.person,
                textInputAction: TextInputAction.next,
                onSubmitted: (_) => FocusScope.of(context).nextFocus(),
              ),
        SizedBox(height: ThemeAppSize.kInterval24),
        myTextField(
          controller: controller.cEmail,
          text: 'Ivan@gmail.com',
          icon: Icons.mail,
          textInputAction: TextInputAction.next,
          onSubmitted: (_) => FocusScope.of(context).nextFocus(),
        ),
        SizedBox(height: ThemeAppSize.kInterval24),
        myTextField(
          controller: controller.cPassword,
          text: 'Password',
          icon: Icons.key,
          textInputAction: TextInputAction.next,
          onSubmitted: (_) => FocusScope.of(context).nextFocus(),
        ),
        myAuthButton(() {
          final String email = controller.cEmail.text;
          final String pass = controller.cPassword.text;
          controller.authUser(email: email, pass: pass);
        }, isLog ? 'Login' : 'Register'),
      ],
    );
  }
}

class _ToggScreenTextWidget extends StatelessWidget {
  const _ToggScreenTextWidget();
  @override
  Widget build(BuildContext context) {
    final model = context.watch<AuthModel>();
    return Row(
      children: [
        const SmallText(
          text: 'wwwerw',
          color: ThemeAppColor.kFrontColor,
        ),
        SizedBox(width: ThemeAppSize.kInterval12),
        InkWell(
            onTap: () => model.togScreenAuth(),
            child: const BigText(
              text: 'adafadf ? ',
              color: ThemeAppColor.kFrontColor,
            ))
      ],
    );
  }
}
