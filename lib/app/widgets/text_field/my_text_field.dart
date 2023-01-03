import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

      child: TextField(
        autofocus: false,
        onSubmitted: (_) => FocusScope.of(context).nextFocus(),
        controller: controller,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        obscureText: obscureText,
        cursorColor: context.theme.cardColor,

        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10),
          labelText: text,
          labelStyle: TextStyle(
            color: context.theme.cardColor,
          ),
          isDense: true,
          fillColor: context.theme.cardColor,
          prefixIcon: icon != null
              ? Icon(
                  icon, //color: context.theme.backgroundColor
                )
              : null,
          hintText: hintText,
          border: InputBorder.none,

          //enabledBorder: styleInput,
          // focusedBorder: styleInput,
        ),
      ),
    );
  }
}
