import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text/ui/widgets/text/small_text.dart';

import '../../../services/auth.dart';
import '../../theme/theme_app.dart';
import '../../widgets/text/big_text.dart';
import '../../widgets/text_field/my_auth_button.dart';
import '../../widgets/text_field/my_text_field.dart';
import 'auth_model.dart';

final _cEmail = TextEditingController();
final _cPassword = TextEditingController();

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final auth = AuthServices();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(ThemeAppSize.kInterval24),
        child: Column(
          children: [
            const _LoginBody(),
            SizedBox(height: ThemeAppSize.kInterval24),
            const _LoginToRegister(),
            SizedBox(height: ThemeAppSize.kInterval24),
            myAuthButton(() {
              auth.userLogin(
                context,
                email: _cEmail.text,
                password: _cPassword.text,
              );
            }, 'Login')
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
    return Column(
      children: [
        myTextField(
          controller: _cEmail,
          text: 'Ivan@gmail.com',
          icon: Icons.mail,
          textInputAction: TextInputAction.next,
          onSubmitted: (_) => FocusScope.of(context).nextFocus(),
        ),
        SizedBox(height: ThemeAppSize.kInterval24),
        myTextField(
          controller: _cPassword,
          text: 'Password',
          icon: Icons.key,
          textInputAction: TextInputAction.next,
          onSubmitted: (_) => FocusScope.of(context).nextFocus(),
        ),
      ],
    );
  }
}

class _LoginToRegister extends StatelessWidget {
  const _LoginToRegister();

  @override
  Widget build(BuildContext context) {
    final model = context.read<AuthModel>();
    return Row(
      children: [
        const SmallText(
          text: 'wwwerw',
          color: ThemeAppColor.kFrontColor,
        ),
        SizedBox(width: ThemeAppSize.kInterval12),
        InkWell(
            onTap: () => model.showRegister(context),
            child: const BigText(
              text: 'adafadf ? ',
              color: ThemeAppColor.kFrontColor,
            )),
      ],
    );
  }
}
