// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/pages/primary_pages/profile/favorite/controller/favorite_controller.dart';
import 'package:text/app/pages/primary_pages/guiding/controller/guiding_controller.dart';
import 'package:text/app/pages/primary_pages/profile/profile_history.dart';
import 'package:text/app/pages/primary_pages/profile/profile_setting_page/profile_setting.dart';
import '../../../controllers/auth_controller.dart';
import '../../../controllers/cart_controller.dart';
import '../../../theme/theme_app.dart';
import '../../../theme/theme_controller.dart';
import '../../../widgets/show_dialog/custom_show_dialog.dart';
import '../../../widgets/text/my_text.dart';

class HeaderProfile extends StatelessWidget {
  const HeaderProfile({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ThemeAppSize.kHeight100 * 3.3,
      child: Stack(
        children: [
          const _Achievement(),
          _ImgAndInfo(),
          const _HeaderIcons(),
        ],
      ),
    );
  }
}

Widget wrapContainer({color, height, required Widget widget}) {
  return Container(
    width: double.infinity,
    height: height,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(
          ThemeAppSize.kRadius18 * 1.5,
        ),
      ),
      boxShadow: const [
        BoxShadow(
          color: Color.fromARGB(255, 33, 33, 33),
          spreadRadius: 2,
          blurRadius: 5,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: widget,
  );
}

class _ImgAndInfo extends StatelessWidget {
  _ImgAndInfo();
  final controller = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    final guidingController = Get.find<GuidingController>();
    final sizeCircleAvatar = ThemeAppSize.kInterval12 * 5;

    return wrapContainer(
      color: context.theme.scaffoldBackgroundColor,
      height: ThemeAppSize.kHeight100 * 2.5,
      widget: Obx(() => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (controller.userData['imgURL'] != null &&
                  controller.userData['imgURL'] != "")
                CircleAvatar(
                  radius: guidingController.startAnimationProfile.value
                      ? sizeCircleAvatar
                      : 10,
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(
                      controller.userData['imgURL'].toString()),
                )
              else
                Stack(
                  children: [
                    /// icon img
                    CircleAvatar(
                      radius: guidingController.startAnimationProfile.value
                          ? sizeCircleAvatar
                          : 10,
                      backgroundColor: Colors.grey,
                      backgroundImage: const AssetImage('assets/imgs/user.jpg'),
                    ),

                    /// icon add
                    Positioned(
                      bottom: -ThemeAppSize.kInterval5 / 2.5,
                      right: -ThemeAppSize.kInterval5 / 2.5,
                      child: InkWell(
                        onTap: () {

                        },
                        child: Icon(
                          Icons.error_outline_outlined,
                          size: ThemeAppSize.kFontSize16 * 2,
                          color: context.theme.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              BigText(
                text: controller.userData['name'] ?? '',
                size: ThemeAppSize.kFontSize16 * 1.5,
              ),
            ],
          )),
    );
  }
}

class _Achievement extends StatelessWidget {
  const _Achievement();
  @override
  Widget build(BuildContext context) {
    Widget achievementItem(text, count) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SmallText(
            text: count.toString(),
            color: context.theme.accentColor,
          ),
          SmallText(
            maxLines: 2,
            text: text,
            color: context.theme.accentColor,
          ),
        ],
      );
    }

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: wrapContainer(
        color: context.theme.cardColor,
        height: ThemeAppSize.kHeight100 * 3.3,
        widget: Padding(
          padding: EdgeInsets.all(
            ThemeAppSize.kInterval24 - ThemeAppSize.kInterval5,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () =>
                    Get.find<GuidingController>().setCurrentIndexTab(2),
                child: GetBuilder<FavoriteController>(
                  builder: (_) {
                    return achievementItem(
                      'favorite'.tr,
                      _.getFavoriteList.length,
                    );
                  },
                ),
              ),
              InkWell(
                onTap: () => customShowDialog(
                  widget: const HistoryPayProfile(),
                ),
                child: GetBuilder<CartController>(
                  builder: (_) {
                    return achievementItem('buy'.tr, _.getHistoryList().length);
                  },
                ),
              ),
              GetBuilder<CartController>(
                builder: (_) {
                  var total = _.totalPrice();
                  return achievementItem('bought_on'.tr, '$total \$');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderIcons extends StatelessWidget {
  const _HeaderIcons();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(ThemeAppSize.kInterval12),
      child: Row(
        children: [
          InkWell(
            onTap: () => Get.find<ThemeAppController>().tooggTheme(),
            child: Icon(
              Icons.dark_mode,
              color: context.theme.hintColor,
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: () => customShowDialog(widget: const ProfileSetting()),
            child: Icon(
              Icons.settings,
              color: context.theme.hintColor,
            ),
          ),
        ],
      ),
    );
  }
}
