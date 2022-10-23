import 'package:flutter/material.dart';
import 'package:text/ui/widgets/text/big_text.dart';
import '../../theme/theme_app.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          _AuthTextFieldWidget(),
          _AuthButtonWidget(),
        ],
      ),
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({super.key, required this.name, required this.icon});
  final IconData icon;
  final String name;
  @override
  Widget build(BuildContext context) {
    InputBorder styleSearch = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(ThemeAppSize.kInterval12)),
      borderSide: const BorderSide(style: BorderStyle.solid),
    );
    return TextField(
      cursorColor: ThemeAppColor.kFrontColor,
      decoration: InputDecoration(
        isDense: true,
        fillColor: ThemeAppColor.kBGColor,
        prefixIcon: Icon(
         icon,
          color: ThemeAppColor.kFrontColor
        ),
        hintText: name,
        enabledBorder: styleSearch,
        focusedBorder: styleSearch,
      ),
    );
  }
}

class _AuthTextFieldWidget extends StatelessWidget {
  const _AuthTextFieldWidget();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(ThemeAppSize.kInterval24),
      child: Column(
        children: [
          const TextFieldWidget(name: 'Ivan', icon: Icons.person),
          SizedBox(height: ThemeAppSize.kInterval24),
          const TextFieldWidget(name: 'password', icon: Icons.key),
          SizedBox(height: ThemeAppSize.kInterval24),
          const TextFieldWidget(name: '23 Chapel Hill', icon: Icons.home),
          SizedBox(height: ThemeAppSize.kInterval24),
          const TextFieldWidget(name: '+1-234-567-890', icon: Icons.phone),
        ],
      ),
    );
  }
}

class _AuthButtonWidget extends StatelessWidget {
  const _AuthButtonWidget();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(ThemeAppSize.kInterval24),
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
