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
          _IconSetting(),
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

class _IconSetting extends StatelessWidget {
  const _IconSetting();
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: InkWell(
        onTap: () => customShowDialog(widget: const ProfileSetting()),
        child: WrapperIcon(

          child: Icon(
            Icons.settings,
            color: context.theme.cardColor,
          ),
        ),
      ),
    );
  }
}
