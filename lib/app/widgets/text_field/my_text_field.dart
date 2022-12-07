import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/theme_app.dart';
class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.icon,
    this.hintText = '',
    required this.controller,
    required this.text,
  });
  final TextEditingController controller;
  final String text;
  final bool obscureText;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final dynamic icon;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      shadowColor: Colors.black,
      color: Colors.white,
      borderRadius: BorderRadius.all(
        Radius.circular(ThemeAppSize.kInterval12),
      ),
      child: TextField(
        autofocus: false,
        onSubmitted: (_) => FocusScope.of(context).nextFocus(),
        controller: controller,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        obscureText: obscureText,
        cursorColor: Get.theme.backgroundColor,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10),
          labelText: text,
          labelStyle: TextStyle(
            color: Get.theme.backgroundColor,
          ),
          isDense: true,
          fillColor: Get.theme.cardColor,
          prefixIcon: icon != null
              ? Icon(icon, color: Get.theme.backgroundColor)
              : null,
          hintText: hintText,
          border: InputBorder.none,
          // enabledBorder: styleInput,
          // focusedBorder: styleInput,
        ),
      ),
    );
  }
}
