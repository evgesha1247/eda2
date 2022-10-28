import 'package:flutter/material.dart';
import '../../theme/theme_app.dart';

myTextField({
  required controller,
  required text,
  keyboardType,
  textInputAction,
  obscureText = false,
  icon,
  hintText,
  onSubmitted,
}) {
  // InputBorder styleInput = OutlineInputBorder(
  //   borderRadius: BorderRadius.all(Radius.circular(ThemeAppSize.kInterval12)),
  //   borderSide: BorderSide.none,
  // );
  return Material(
    elevation: 2,
    shadowColor: Colors.black,
    color: Colors.white,
    borderRadius: BorderRadius.all(
      Radius.circular(ThemeAppSize.kInterval12),
    ),
    child: TextField(
      autofocus: false,
      onSubmitted: onSubmitted,
      controller: controller,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      obscureText: obscureText,
      cursorColor: ThemeAppColor.kFrontColor,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        labelText: text,
        labelStyle: const TextStyle(
          color: ThemeAppColor.kFrontColor,
        ),
        isDense: true,
        fillColor: ThemeAppColor.kBGColor,
        prefixIcon: Icon(icon, color: ThemeAppColor.kFrontColor),
        hintText: hintText,
        border: InputBorder.none,
        // enabledBorder: styleInput,
        // focusedBorder: styleInput,
      ),
    ),
  );
}
