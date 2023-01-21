// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/pages/primary_pages/profile/profile_page.dart';
import '../../../controllers/auth_controller.dart';
import '../../../theme/theme_app.dart';
import '../../../widgets/text/my_text.dart';

class ProfileBody extends StatelessWidget {
  ProfileBody({super.key});
  final controller = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(ThemeAppSize.kInterval24),
        child: ListView(
          shrinkWrap: true,
          children: [
            UserInfo(),

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

class UserInfo extends StatelessWidget {
  UserInfo({super.key});
  final controller = Get.find<AuthController>();
  final List dataKey = const ['email', 'phone'];
  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            ...List.generate(
              dataKey.length,
              (index) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmallText(text: dataKey[index]),
                  SmallText(
                    text: controller.userData.value[dataKey[index]] ?? '',
                    size: ThemeAppSize.kFontSize16 * 1.5,
                  ),
                ],
              ),
            ),
            SizedBox(height: ThemeAppSize.kInterval24),
          ],
        ));
  }
}
