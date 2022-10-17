import 'package:flutter/material.dart';
import 'package:text/ui/widgets/text/big_text.dart';
import 'package:text/ui/widgets/text/small_text.dart';
import '../../theme/theme_app.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _AuthWidget(),
    );
  }
}

class _AuthWidget extends StatelessWidget {
  const _AuthWidget();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _AuthHeaderWidget(),
        _AuthBodyWidget(),
      ],
    );
  }
}

class _AuthHeaderWidget extends StatelessWidget {
  const _AuthHeaderWidget();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(ThemeAppSize.kInterval12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: ThemeAppSize.width / 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.all(ThemeAppSize.kInterval12),
                      child: const BigText(
                        decoration: TextDecoration.underline,
                        text: 'Login',
                        color: ThemeAppColor.kFrontColor,
                      ),
                    )),
                GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.all(ThemeAppSize.kInterval12),
                      child: const BigText(
                        text: 'Sing Up',
                        color: ThemeAppColor.kFrontColor,
                      ),
                    )),
              ],
            ),
          ),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: ThemeAppFun.decoration(radius: 15),
                color: ThemeAppColor.kFrontColor),
            child: const Center(
              child: Icon(
                Icons.person,
                color: ThemeAppColor.kBGColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _AuthBodyWidget extends StatelessWidget {
  const _AuthBodyWidget();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(ThemeAppSize.kInterval24),
        decoration: const BoxDecoration(
          color: ThemeAppColor.kFrontColor,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            const _AuthLeadingWidget(),
            SizedBox(height: ThemeAppSize.kInterval24),
            const _AuthTextFieldWidget(),
            SizedBox(height: ThemeAppSize.kInterval24),
            const _TextToRegister(),
            SizedBox(height: ThemeAppSize.kInterval24),
            const _AuthButtonWidget()
          ],
        ),
      ),
    );
  }
}

class _TextToRegister extends StatelessWidget {
  const _TextToRegister();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
          onTap: () {},
          child: const SmallText(text: 'don\'t have an account yet?')),
    );
  }
}

class _AuthLeadingWidget extends StatelessWidget {
  const _AuthLeadingWidget();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const BigText(
            text: "Hello ",
            color: ThemeAppColor.kBGColor,
            size: 35,
          ),
          SmallText(
            color: ThemeAppColor.kBGColor.withOpacity(0.7),
            text:
                "Enter your informations below or login with a social account",
          )
        ],
      ),
    );
  }
}

class _AuthTextFieldWidget extends StatelessWidget {
  const _AuthTextFieldWidget();
  Widget textFieldWidget({
    required String name,
    required IconData icon,
  }) {
    InputBorder styleSearch = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(ThemeAppSize.kInterval12)),
      borderSide: const BorderSide(style: BorderStyle.solid),
    );
    return TextField(
      cursorColor: ThemeAppColor.kFrontColor,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        isDense: true,
        filled: true,
        fillColor: ThemeAppColor.kBGColor,
        prefixIcon: Icon(
          icon,
          color: ThemeAppColor.kFrontColor,
        ),
        hintText: name,
        enabledBorder: styleSearch,
        focusedBorder: styleSearch,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        textFieldWidget(name: 's@gmail.com', icon: Icons.email),
        SizedBox(height: ThemeAppSize.kInterval24),
        textFieldWidget(name: '******', icon: Icons.key),
      ],
    );
  }
}

class _AuthButtonWidget extends StatelessWidget {
  const _AuthButtonWidget();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ThemeAppColor.kBGColor,
        borderRadius: ThemeAppFun.decoration(radius: 10),
      ),
      width: double.infinity,
      height: 35,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          BigText(
            text: 'login',
            color: ThemeAppColor.kFrontColor,
          ),
          Icon(Icons.chevron_right)
        ],
      ),
    );
  }
}
