// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/pages/primary_pages/profile/favorite/controller/favorite_controller.dart';
import 'package:text/app/pages/primary_pages/guiding/controller/guiding_controller.dart';
import 'package:text/app/pages/primary_pages/profile/profile_history.dart';
import 'package:text/app/pages/primary_pages/profile/profile_page.dart';
import 'package:text/app/pages/primary_pages/profile/profile_setting_page/profile_setting.dart';
import '../../../controllers/auth_controller.dart';
import '../../../controllers/cart_controller.dart';
import '../../../theme/theme_app.dart';
import '../../../widgets/icon/wrap_icon.dart';
import '../../../widgets/show_dialog/custom_show_dialog.dart';
import '../../../widgets/text/my_text.dart';

class HeaderProfile extends StatelessWidget {
  const HeaderProfile({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ThemeAppSize.height / 2.5,
      child: Stack(
        children: const [
          _ImgUser(),
          _ProgresUser(),
         _HeaderIcons()
        ],
      ),
    );
  }
}


class _ImgUser extends StatelessWidget {
  const _ImgUser();
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    final radius = BorderRadius.vertical(
      bottom: Radius.circular(ThemeAppSize.kRadius18),
    );
    return Obx(() {
      final String? img = controller.userData['imgURL'];
      return Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: radius,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  (img != null && img != "") ? img.toString() : 'https://goo.su/XVCX',
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: radius,
              gradient: const LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [Colors.transparent, Color.fromARGB(235, 0, 0, 0)],
                stops: [0.6, 1],
              ),
            ),
          )
        ],
      );
    }
    );
  }
}

class _ProgresUser extends StatelessWidget {
  const _ProgresUser();
  @override
  Widget build(BuildContext context) {
    Widget achievementItem(text, count) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BigText(
            size: ThemeAppSize.kFontSize20 * 1.8,
            text: count.toString(),
            color: context.theme.accentColor,
            height: 0,
          ),
          SmallText(
            height: 0,
            text: text,
            color: context.theme.accentColor,
          ),
        ],
      );
    }
    final guidingC = Get.find<GuidingController>();
    return Padding(
      padding: EdgeInsets.all(ThemeAppSize.kInterval24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () => guidingC.setCurrentIndexTab(2),
            child: GetBuilder<FavoriteController>(
              builder: (_) => achievementItem('favorite'.tr, _.getFavoriteList.length),
            ),
          ),
          //SizedBox(width: ThemeAppSize.kInterval24),
          InkWell(
            onTap: () => customShowDialog(widget: const HistoryPayProfile()),
            child: GetBuilder<CartController>(
              builder: (_) => achievementItem('buy'.tr, '${_.getHistoryList().length}'),
            ),
          ),
          //   SizedBox(width: ThemeAppSize.kInterval24),
          GetBuilder<CartController>(
            builder: (_) {
              var total = _.totalPrice();
              return achievementItem('bought_on'.tr, '$total');
            },
          ),
        ],
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
        children: const [
          _IconSetting(),
          Spacer(),
          _IconEditImg(),
        ],
      ),
    );
  }
}

class _IconSetting extends StatelessWidget {
  const _IconSetting();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => customShowDialog(
        widget: const ProfileSetting(),
        radius: ThemeAppSize.kRadius18,
      ),
      child: WrapperIcon(
        colorBorder: context.theme.accentColor,
        bg: context.theme.scaffoldBackgroundColor,
        child: Icon(
          Icons.settings,
          color: context.theme.accentColor,
        ),
      ),
    );
  }
}

class _IconEditImg extends StatelessWidget {
  const _IconEditImg();
  @override
  Widget build(BuildContext context) {
    final style = OutlineInputBorder(
      borderSide: const BorderSide(color: ThemeAppColor.kTextDark),
      borderRadius: BorderRadius.all(Radius.circular(ThemeAppSize.kRadius12)),
    );
    final auth = Get.find<AuthController>();

    void showMaterialDialog(context) {
      showDialog(
        context: context,
        builder: (context) {
          context = context;
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(ThemeAppSize.kRadius12)),
            ),
            backgroundColor: context.theme.scaffoldBackgroundColor,
            contentPadding: EdgeInsets.all(ThemeAppSize.kInterval12),
            buttonPadding: EdgeInsets.zero,
            iconPadding: EdgeInsets.zero,
            icon: Padding(
              padding: EdgeInsets.only(
                top: ThemeAppSize.kInterval12,
                left: ThemeAppSize.kInterval12,
                right: ThemeAppSize.kInterval12,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmallText(text: 'edit img', color: context.theme.hintColor),
                  InkWell(
                    onTap: () => Get.back(),
                    child: Icon(
                      Icons.close,
                      color: context.theme.hintColor,
                    ),
                  ),
                ],
              ),
            ),
            content: TextField(
              controller: auth.cPhotoURL,
              cursorColor: context.theme.primaryColor,
              decoration: InputDecoration(
                isDense: true,
                label: BigText(
                  text: 'URL',
                  color: context.theme.hintColor,
                  size: ThemeAppSize.kFontSize20,
                ),
                hintStyle: const TextStyle(color: ThemeAppColor.kTextDark),
                border: style,
                focusedBorder: style,
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(
                  bottom: ThemeAppSize.kInterval12,
                  right: ThemeAppSize.kInterval12,
                ),
                child: InkWell(
                  onTap: () => auth.saveUpData(),
                  child: const MyButtonString(text: 'Применить'),
                ),
              )
            ],
          );
        },
      );
    }

    return InkWell(
      onTap: () => showMaterialDialog(context),
      child: WrapperIcon(
        colorBorder: context.theme.accentColor,
        bg: context.theme.scaffoldBackgroundColor,
        child: Icon(
          Icons.image_search_rounded,
          color: context.theme.accentColor,
        ),
      ),
    );
  }
}
