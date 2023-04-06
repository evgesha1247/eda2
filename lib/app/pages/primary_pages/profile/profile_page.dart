import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/pages/primary_pages/profile/profile_body.dart';
import 'package:text/app/pages/primary_pages/profile/profile_header.dart';
import '../../../theme/theme_app.dart';
import '../../../widgets/text/my_text.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        HeaderProfile(),
        BodyProfile(),
      ],
    );
  }
}

class MyButtonString extends StatelessWidget {
  const MyButtonString({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ThemeAppSize.kInterval12,
        vertical: ThemeAppSize.kInterval5,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: context.theme.primaryColor),
        borderRadius: BorderRadius.all(
          Radius.circular(
            ThemeAppSize.kRadius12 / 2
          ),
        ),
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          BigText(
            text: text,
            color: context.theme.primaryColor,
          ),
        ],
      ),
    );
  }
}
