import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/auth.dart';
import '../../theme/theme_app.dart';
import '../../widgets/text/big_text.dart';
import '../../widgets/text/small_text.dart';
import '../../widgets/text_field/my_auth_button.dart';
import '../../widgets/text_field/my_text_field.dart';
import 'auth_model.dart';

final _cName = TextEditingController();
final _cEmail = TextEditingController();
final _cPassword = TextEditingController();

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final auth = AuthServices();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(ThemeAppSize.kInterval24),
        child: Column(
          children: [
            const _RegisterBody(),
            SizedBox(height: ThemeAppSize.kInterval24),
            const _RegisterToLogin(),
            SizedBox(height: ThemeAppSize.kInterval24),
            myAuthButton(() {
              auth.userRegister(
                context,
                email: _cEmail.text,
                password: _cPassword.text,
              );
            }, 'Register')
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
    return Column(
      children: [
        myTextField(
          controller: _cName,
          text: 'Ivan',
          icon: Icons.person,
          textInputAction: TextInputAction.next,
          onSubmitted: (_) => FocusScope.of(context).nextFocus(),
        ),
        SizedBox(height: ThemeAppSize.kInterval24),
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

class _RegisterToLogin extends StatelessWidget {
  const _RegisterToLogin();
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
            onTap: () => model.showLogin(context),
            child: const BigText(
              text: 'adafadf ? ',
              color: ThemeAppColor.kFrontColor,
            )),
      ],
    );
  }
}
