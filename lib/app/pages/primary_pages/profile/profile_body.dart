import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../../theme/theme_app.dart';
import '../../../widgets/button/my_button.dart';
import '../../../widgets/text/my_text.dart';

class ProfileListTile {
  final String text;
  final IconData icon;
  final Function fun;
  const ProfileListTile({
    required this.text,
    required this.icon,
    required this.fun,
  });
}

class _ItemsListTile extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function fun;
  const _ItemsListTile({
    required this.text,
    required this.icon,
    required this.fun,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => fun(),
          child: Card(
            elevation: 5,
            shadowColor: context.theme.cardColor,
            color: context.theme.scaffoldBackgroundColor,
            child: ListTile(
              leading: Icon(icon, color: context.theme.hintColor),
              title: BigText(text: text),
              trailing: Icon(Icons.more_vert, color: context.theme.hintColor),
            ),
          ),
        ),
        SizedBox(height: ThemeAppSize.kInterval12),
      ],
    );
  }
}

class ProfileUserInfo extends StatelessWidget {
  ProfileUserInfo({super.key});
  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final List<ProfileListTile> profileListTile = [
      ProfileListTile(
        text: 'history',
        icon: Icons.history,
        fun: controller.logoutUser,
      )
    ];

    final List<_ItemsListTile> itemsListTile = profileListTile
        .map((ProfileListTile e) => _ItemsListTile(
              text: e.text,
              icon: e.icon,
              fun: controller.logoutUser,
            ))
        .toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          BigText(text: controller.user.value?.displayName ?? '#NAME'),
          Column(
            children: itemsListTile,
          ),
          const MyButtonString(text: 'logout')
        ],
      ),
    );
  }
}
