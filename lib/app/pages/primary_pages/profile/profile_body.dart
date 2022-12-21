// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/pages/primary_pages/profile/profile_history.dart';
import 'package:text/app/widgets/show_dialog/custom_show_dialog.dart';
import '../../../controllers/auth_controller.dart';
import '../../../theme/theme_app.dart';
import '../../../widgets/button/my_button.dart';
import '../../../widgets/text/my_text.dart';

class ProfileBody extends StatelessWidget {
  ProfileBody({super.key});
  final controller = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(ThemeAppSize.kInterval12),
      child: Column(
        children: [
          BigText(text: controller.user?.value?.displayName ?? '#NAME'),
          SizedBox(height: ThemeAppSize.kInterval12),
          Column(children: [
            _ItemsListTile(
              text: 'history',
              icon: Icons.history,
              fun: () => customShowDialog(widget: const ProfileHistory()),
            ),
          ]),
          const Spacer(),
          const MyButtonString(text: 'logout')
        ],
      ),
    );
  }
}

class _ItemsListTile extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function fun;
  const _ItemsListTile({
    required this.text,
    required this.icon,
    required this.fun
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => fun(),
          child: Card(
            elevation: 8,
            shadowColor: Colors.grey[800],
            color: context.theme.cardColor,
            child: ListTile(
              leading: Icon(icon, color: context.theme.accentColor),
              title: BigText(
                text: text,
                color: context.theme.accentColor,
              ),
              trailing: Icon(Icons.more_vert, color: context.theme.accentColor),
            ),
          ),
        ),
        SizedBox(height: ThemeAppSize.kInterval12),
      ],
    );
  }
}
