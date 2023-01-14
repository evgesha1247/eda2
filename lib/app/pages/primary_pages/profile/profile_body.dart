// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/pages/primary_pages/profile/profile_page.dart';
import '../../../controllers/auth_controller.dart';
import '../../../theme/theme_app.dart';

class ProfileBody extends StatelessWidget {
  ProfileBody({super.key});
  final controller = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(ThemeAppSize.kInterval12),
        child: Column(
          children: [
            const Spacer(),
            InkWell(
              onTap: () => controller.logoutUser(),
              child: const MyButtonString(
                text: 'logout',
              ),
            )
          ],
        ),
      ),
    );
  }
}
