import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/widgets/icon/wrap_icon.dart';

import '../../theme/theme_app.dart';
import '../text/my_text.dart';

// class MyTextField extends StatelessWidget {
//   final TextEditingController textController;
//   const MyTextField({super.key, required this.textController});

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: textController,
//       cursorColor: ThemeAppColor.kAccent,
//       decoration: InputDecoration(
//         isDense: true,
//         label: BigText(
//           text: 'URL',
//           size: ThemeAppSize.kFontSize20,
//         ),
//         hintStyle: const TextStyle(color: ThemeAppColor.kTextDark),
//         border: style,
//         focusedBorder: style,
//       ),
//     );
//   }
// }
OutlineInputBorder style({Color? color}) => OutlineInputBorder(
      borderSide: BorderSide(color: color ?? Get.context!.theme.hintColor),
      borderRadius: BorderRadius.all(Radius.circular(ThemeAppSize.kRadius12)),
    );

class MyTextField extends StatelessWidget {
  final TextEditingController textController;
  final String text;
  final dynamic icon;
  final dynamic keyboardType;
  const MyTextField({
    super.key,
    this.icon = Icons.edit,
    this.keyboardType = TextInputType.text,
    required this.textController,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    RxBool status = text == 'Password' ? false.obs : true.obs;
    Widget? suffixIcon() {
      if (text != 'Password') return null;
      return InkWell(
        onTap: () => status.value = !status.value,
        child: WrapperIcon(
          colorBorder: context.theme.hintColor.withOpacity(0.5),
          child: Icon(
              status.value ? Icons.visibility_rounded : Icons.visibility_off_rounded,
              color: context.theme.hintColor),
        ),
      );
    }

    return Obx(
      () => TextField(
        controller: textController,
        onSubmitted: (_) => FocusScope.of(context).nextFocus(),
        textInputAction: TextInputAction.next,
        obscureText: !status.value,
        cursorColor: ThemeAppColor.kAccent,
        keyboardType: keyboardType,
        style: TextStyle(color: context.theme.hintColor),
        decoration: InputDecoration(
          hintText: textController.text.toString(),
          isDense: true,
          label: BigText(text: text.tr, fontWeight: FontWeight.w400),
          suffixIcon: suffixIcon(),
          prefixIcon: Icon(icon, color: context.theme.hintColor),
          border: style(),
          focusedBorder: style(color: ThemeAppColor.kAccentCard),
        ),
      ),
    );
  }
}
