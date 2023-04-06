// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/pages/primary_pages/profile/profile_page.dart';
import '../../../controllers/auth_controller.dart';
import '../../../theme/theme_app.dart';
import '../../../widgets/text/my_text.dart';
import 'favorite/favorite_body.dart';

class BodyProfile extends StatelessWidget {
  const BodyProfile({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ThemeAppSize.kInterval24),
      child: Column(
        children: [
          SizedBox(height: ThemeAppSize.kInterval24),
          const _UserName(),
          SizedBox(height: ThemeAppSize.kInterval24),
          const FavoriteSection(),
          SizedBox(height: ThemeAppSize.kInterval24),
          const _UserInfo(),
          SizedBox(height: ThemeAppSize.kInterval24),
          const _UserLogout(),
        ],
      ),
    );
  }
}

class _UserName extends StatelessWidget {
  const _UserName();
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: controller.userData['name'] ?? 'Name is null',
          fontWeight: FontWeight.w500,
          height: 0,
          size: ThemeAppSize.kFontSize18 * 1.5,
        ),
      ],
    );
  }
}

class _UserInfo extends StatelessWidget {
  const _UserInfo();
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    List dataList = ['email', 'phone', 'address'];
    List dataKey = ['email'.tr, 'phone'.tr, 'address'.tr];
    return Obx(
      () => Column(
          children: [
            ...List.generate(
              dataKey.length,
            (index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmallText(text: dataKey[index]),
                  SmallText(
                    text: controller.userData[dataList[index]] ?? '******',
                    size: ThemeAppSize.kFontSize16 * 1.5,
                  ),
                ],
              );
            },
          ),
          ],
      ),
    );



  }
}

class _UserLogout extends StatelessWidget {
  const _UserLogout();
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    return InkWell(
      onTap: () => controller.logoutUser(),
      child: MyButtonString(
        text: 'logout'.tr,
      ),
    );
  }
}
