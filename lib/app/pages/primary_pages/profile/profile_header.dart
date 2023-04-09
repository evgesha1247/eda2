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
      width: double.infinity,
      child: Stack(
        children: const [
          _ImgUser(),
          _ProgresUser(),
          _HeaderIcons(),
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
    return Container(
        height: ThemeAppSize.height / 2.5,
        width: double.infinity,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(ThemeAppSize.kRadius18),
        )),
        child: ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) => const LinearGradient(
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: [Colors.transparent, Color.fromARGB(235, 0, 0, 0)],
            stops: [0.5, 2],
          ).createShader(bounds),
          child: Obx(() {
            return Image.network(
              fit: BoxFit.cover,
              controller.userData['imgURL'].toString(),
              errorBuilder: (context, error, stackTrace) =>
                  Image.asset(fit: BoxFit.cover, 'assets/imgs/error_avatar.png'),
            );
          }),
        ));
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
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Wrap(
          spacing: ThemeAppSize.width / 6,
          children: [
            InkWell(
              onTap: () => guidingC.setCurrentIndexTab(2),
              child: GetBuilder<FavoriteController>(
                builder: (_) => achievementItem('favorite'.tr, _.getFavoriteList.length),
              ),
            ),
            InkWell(
              onTap: () => customShowDialog(widget: const HistoryPayProfile()),
              child: GetBuilder<CartController>(
                builder: (_) => achievementItem('buy'.tr, '${_.getHistoryList().length}'),
              ),
            ),
            GetBuilder<CartController>(
              builder: (_) => achievementItem('bought_on'.tr, '${_.totalPrice()}'),
            ),
          ],
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
        children: const [
          _IconEditImg(),
          Spacer(),
          _IconSetting(),
        ],
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
    Widget title() {
      return Padding(
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
              child: Icon(Icons.close, color: context.theme.hintColor),
            ),
          ],
        ),
      );
    }

    Widget content() {
      return TextField(
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
      );
    }

    Widget submit() {
      return Padding(
        padding: EdgeInsets.only(
          bottom: ThemeAppSize.kInterval12,
          right: ThemeAppSize.kInterval12,
        ),
        child: InkWell(
          onTap: () => auth.setImgUrl(),
          child: const MyButtonString(text: 'Применить'),
        ),
      )
  ;
    }

    return InkWell(
      onTap: () => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(ThemeAppSize.kRadius12)),
          ),
          backgroundColor: context.theme.scaffoldBackgroundColor,
          contentPadding: EdgeInsets.all(ThemeAppSize.kInterval12),
          buttonPadding: EdgeInsets.zero,
          iconPadding: EdgeInsets.zero,
          icon: title(),
          content: content(),
          actions: [submit()],
        ),
      ),
      child: WrapperIcon(
        colorBorder: context.theme.hintColor,
        bg: context.theme.scaffoldBackgroundColor,
        child: Icon(
          Icons.image_search_rounded,
          color: context.theme.hintColor,
        ),
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
        colorBorder: context.theme.hintColor,
        bg: context.theme.scaffoldBackgroundColor,
        child: Icon(
          Icons.settings,
          color: context.theme.hintColor,
        ),
      ),
    );
  }
}
