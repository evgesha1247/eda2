import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text/ui/screens/auth_screens/auth_model.dart';
import '../../theme/theme_app.dart';
import '../../widgets/text/big_text.dart';
import '../../widgets/text/small_text.dart';
import '../../widgets/text_field/my_auth_button.dart';
import '../../widgets/text_field/my_text_field.dart';

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

class _AuthBody extends StatelessWidget {
  const _AuthBody();
  @override
  Widget build(BuildContext context) {
    final constroller = context.watch<AuthModel>();
    final bool isLog = constroller.isLogScreen;
    final String email = constroller.cEmail.text;
    final String pass = constroller.cPassword.text;

    return Column(
      children: [
        isLog
            ? const SizedBox.shrink()
            : myTextField(
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
          constroller.authUser(email: email, pass: pass);
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
