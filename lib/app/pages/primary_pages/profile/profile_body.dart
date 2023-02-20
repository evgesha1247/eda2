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
              child: MyButtonString(
                text: 'logout'.tr,
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  UserInfo({super.key});
  final controller = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    List dataList = ['email', 'phone', 'address'];
    List dataKey = ['email'.tr, 'phone'.tr, 'address'.tr];
    return Obx(() => Column(
          children: [
            ...List.generate(
              dataKey.length,
              (index) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmallText(text: dataKey[index]),
                  SmallText(
                    text: controller.userData[dataList[index]] ?? '',
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
