// ignore_for_file: deprecated_member_use
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/controllers/product_controller.dart';
import 'package:text/app/pages/primary_pages/profile/controller/profile_cobtroller.dart';
import 'package:text/app/pages/primary_pages/profile/profile_page.dart';
import 'package:text/app/widgets/icon/wrap_icon.dart';
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
    return GetBuilder<ProfileController>(
      builder: (_) {
        return Stack(
          children: [
            Container(
              padding: EdgeInsets.all(ThemeAppSize.kInterval24),
              decoration: BoxDecoration(
                color: _.isVisibility
                    ? context.theme.hintColor.withOpacity(0.2)
                    : Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(ThemeAppSize.kRadius12)),
                border: Border.all(color: context.theme.hintColor, width: .5),
              ),
              child: ClipRRect(
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(
                      sigmaX: _.isVisibility ? 5 : 0, sigmaY: _.isVisibility ? 5 : 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const _InfoTitle(title: 'Общая информация'),
                      SizedBox(height: ThemeAppSize.kInterval12),
                      const _InfoItemBuilder(),
                      SizedBox(height: ThemeAppSize.kInterval12),
                      InkWell(
                          onTap: () => _.togVisibility(),
                          child: SmallText(
                            text: 'скрыть инфу',
                            size: 16,
                            color: Colors.black.withOpacity(0.6),
                          )),
                    ],
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Center(
                child: GestureDetector(
                  onTap: () => _.isVisibility ? _.togVisibility() : {},
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: _.isVisibility ? 1 : 0,
                    child: WrapperIcon(
                      colorBorder: context.theme.hintColor,
                      child: Icon(Icons.visibility_off, color: context.theme.hintColor),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _InfoTitle extends StatelessWidget {
  final String title;
  const _InfoTitle({required this.title});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SmallText(
          text: title,
          color: context.theme.hintColor.withOpacity(0.5),
        ),
        const Spacer(),
        WrapperIcon(
          colorBorder: context.theme.hintColor,
          child: Icon(Icons.edit, color: context.theme.hintColor),
        ),
      ],
    );
  }
}

class _InfoItemBuilder extends StatelessWidget {
  const _InfoItemBuilder();
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    List dataKey = ['email'.tr, 'phone'.tr, 'address'.tr];
    List dataList = ['email', 'phone', 'address'];
    return Column(
      children: List.generate(
        dataKey.length,
        (index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SmallText(text: dataKey[index]),
              Obx(() => SmallText(
                    text: controller.userData[dataList[index]] ?? 'нет данных',
                  )),
            ],
          );
        },
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
