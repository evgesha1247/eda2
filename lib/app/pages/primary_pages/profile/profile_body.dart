// ignore_for_file: deprecated_member_use
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/pages/primary_pages/guiding/controller/guiding_controller.dart';
import 'package:text/app/pages/primary_pages/profile/controller/profile_cobtroller.dart';
import 'package:text/app/pages/primary_pages/profile/profile_page.dart';
import 'package:text/app/widgets/icon/wrap_icon.dart';
import '../../../controllers/auth_controller.dart';
import '../../../theme/theme_app.dart';
import '../../../widgets/animation/anim_scale.dart';
import '../../../widgets/text/my_text.dart';
import 'favorite/favorite_body.dart';

class BodyProfile extends StatelessWidget {
  const BodyProfile({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _UserName(),
        FavoriteSection(),
        _UserInfoSection(),
        _UserLogout(),
      ],
    );
  }
}

class _UserName extends StatelessWidget {
  const _UserName();
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    final pCon = Get.find<ProfileController>();
    final style = OutlineInputBorder(
        borderSide: const BorderSide(color: ThemeAppColor.kTextDark),
        borderRadius: BorderRadius.all(Radius.circular(
          ThemeAppSize.kRadius12,
        )));
    return AnimationScaleWidget(
      select: Get.find<GuidingController>().startAnimationProfile,
      widget: Obx(() => Container(
            padding: EdgeInsets.symmetric(
              vertical: ThemeAppSize.kInterval24,
              horizontal: ThemeAppSize.kInterval24,
            ),
            child: (controller.userData['name'] != null &&
                    controller.userData['name'].toString().trim() != '' &&
                    pCon.isEditName.value)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BigText(
                        text: controller.userData['name'].toString(),
                        fontWeight: FontWeight.w500,
                        height: 0,
                        size: ThemeAppSize.kFontSize18 * 1.8,
                      ),
                      InkWell(
                        onTap: () => pCon.togEditName(),
                        child: WrapperIcon(
                          colorBorder: context.theme.hintColor,
                          child: Icon(Icons.edit, color: context.theme.hintColor),
                        ),
                      ),
                    ],
                  )
                : TextField(
                    controller: controller.cName,
                    cursorColor: context.theme.primaryColor,
                    decoration: InputDecoration(
                      suffixIcon: InkWell(
                        onTap: () {
                          controller.setName();
                          pCon.togEditName();
                        },
                        child: WrapperIcon(
                          colorBorder: context.theme.hintColor,
                          child: Icon(Icons.edit, color: context.theme.hintColor),
                        ),
                      ),
                      isDense: true,
                      label: BigText(
                        text: 'User_name'.tr,
                        color: context.theme.hintColor,
                      ),
                      border: style,
                      focusedBorder: style,
                    ),
                  ),
          )),
    );
  }
}

class _UserInfoSection extends StatelessWidget {
  const _UserInfoSection();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ThemeAppSize.kInterval12),
      child: Stack(
        children: const [
          _UserInfoOpen(),
          _UserInfoClose(),
        ],
      ),
    );
  }
}

class _UserInfoOpen extends StatelessWidget {
  const _UserInfoOpen();
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    return Obx(() => Container(
          padding: EdgeInsets.all(ThemeAppSize.kInterval24),
          decoration: BoxDecoration(
            color: controller.isVisibility.value
                ? context.theme.hintColor.withOpacity(0.2)
                : Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(ThemeAppSize.kRadius12)),
            border: Border.all(color: context.theme.hintColor, width: .5),
          ),
          child: ClipRRect(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(
                  sigmaX: controller.isVisibility.value ? 4 : 0,
                  sigmaY: controller.isVisibility.value ? 4 : 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      SmallText(
                          text: 'Общая информация',
                          size: ThemeAppSize.kFontSize16 * 1.5,
                          color: context.theme.hintColor),
                      const Spacer(),
                      WrapperIcon(
                        colorBorder: context.theme.hintColor,
                        child: Icon(Icons.edit_note, color: context.theme.hintColor),
                      ),
                    ],
                  ),
                  SizedBox(height: ThemeAppSize.kInterval12),
                  Divider(
                    color: context.theme.hintColor,
                    height: ThemeAppSize.kInterval5,
                    thickness: 0.5,
                  ),
                  SizedBox(height: ThemeAppSize.kInterval12),
                  const _InfoItemBuilder(),
                  SizedBox(height: ThemeAppSize.kInterval12),
                  InkWell(
                      onTap: () => controller.togVisibility(),
                      child: WrapperIcon(
                        colorBorder: context.theme.hintColor,
                        child: Wrap(
                          children: [
                            SmallText(
                                text: 'скрыть инфу',
                                size: 16,
                                color: context.theme.hintColor),
                            SizedBox(width: ThemeAppSize.kInterval12),
                            Icon(
                              Icons.no_encryption_gmailerrorred_outlined,
                              size: 16,
                              color: context.theme.hintColor,
                            )
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
        ));
  }
}

class _UserInfoClose extends StatelessWidget {
  const _UserInfoClose();
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    return Positioned.fill(
      child: Center(
        child: Obx(() => GestureDetector(
              onTap: () => controller.togVisibility(),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: controller.isVisibility.value ? 1 : 0,
                child: WrapperIcon(
                  colorBorder: context.theme.hintColor,
                  child: Icon(Icons.visibility_off, color: context.theme.hintColor),
                ),
              ),
            )),
      ),
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
    return Obx(
      () => Column(
      children: List.generate(
        dataKey.length,
        (index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SmallText(text: dataKey[index]),
                SmallText(
                    text: controller.userData[dataList[index]] ?? 'нет данных',
                ),
            ],
          );
        },
        ),
      ),
    );
  }
}

class _UserLogout extends StatelessWidget {
  const _UserLogout();
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    void showMaterialDialog(context) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(ThemeAppSize.kRadius12)),
              side: const BorderSide(color: ThemeAppColor.kAccent),
            ),
            backgroundColor: context.theme.scaffoldBackgroundColor,
            titlePadding: EdgeInsets.all(ThemeAppSize.kInterval24),
            actionsPadding: EdgeInsets.all(ThemeAppSize.kInterval24),
            contentPadding: EdgeInsets.symmetric(horizontal: ThemeAppSize.kInterval24),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                BigText(text: 'Вы уверины ?'),
                BigText(
                  text: '!',
                  color: ThemeAppColor.kAccent,
                  size: 30,
                  fontWeight: FontWeight.w900,
                ),
              ],
            ),
            content: const SmallText(
                text: 'при выходе из аккаунта вы не сможите осуществлять заказы'),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: const SmallText(text: 'отмена'),
                  ),
                  InkWell(
                    onTap: () => controller.logoutUser(),
                    child: const SmallText(text: 'ок'),
                  ),
                ],
              ),
            ],
          );
        },
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: ThemeAppSize.kInterval24),
      child: InkWell(
        onTap: () => showMaterialDialog(context),
        child: MyButtonString(
          text: 'logout'.tr,
        ),
      ),
    );
  }
}
