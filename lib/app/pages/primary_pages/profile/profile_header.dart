import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/pages/primary_pages/profile/favorite/controller/favorite_controller.dart';
import 'package:text/app/pages/primary_pages/guiding/controller/guiding_controller.dart';
import 'package:text/app/pages/primary_pages/profile/profile_history.dart';
import 'package:text/app/pages/primary_pages/profile/profile_setting_page/profile_setting.dart';
import '../../../controllers/auth_controller.dart';
import '../../../controllers/cart_controller.dart';
import '../../../theme/theme_app.dart';
import '../../../widgets/animation/anim_scale.dart';
import '../../../widgets/icon/wrap_icon.dart';
import '../../../widgets/show_dialog/custom_show_dialog.dart';
import '../../../widgets/text/my_button_text.dart';
import '../../../widgets/text/my_text.dart';
import '../../../widgets/text_field/my_text_field.dart';
import 'favorite/favorite_page.dart';

class HeaderProfile extends StatelessWidget {
  const HeaderProfile({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ThemeAppSize.height / 2.5,
      width: double.infinity,
      child: const Stack(
        children: [
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

    final _ = Get.find<GuidingController>();
    return Obx(() => AnimatedContainer(
          curve: Curves.ease,
          duration: const Duration(milliseconds: 800),
          transform: Matrix4.translationValues(
              0, _.startAnimationProfile.value ? 0 : -ThemeAppSize.height / 2.5, 0),
          child: AnimationScaleWidget(
            durationMilliseconds: 1000,
            select: _.startAnimationProfile,
            widget: Container(
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
                child: Obx(
                  () {
                    return Image.network(
                      fit: BoxFit.cover,
                      '${controller.userData['imgURL']}',
                      errorBuilder: (context, error, stackTrace) {
                        //////                   //////
                        ///         <Errro>         ///
                        //////                   //////

                        // Get.snackbar('URl', 'link is invalid !',
                        //     snackPosition: SnackPosition.TOP);

                        ////////  </Errro>  //////////

                        return Image.asset(
                          fit: BoxFit.cover,
                          'assets/imgs/error_avatar.png',
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
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
            color: ThemeAppColor.kBGColor,
            height: 0,
          ),
          FittedBox(
            child: SmallText(
              height: 0,
              text: text,
              color: ThemeAppColor.kBGColor,
            ),
          ),
        ],
      );
    }

    final _ = Get.find<GuidingController>();
    return Padding(
      padding: EdgeInsets.all(ThemeAppSize.kInterval24),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          //  spacing: ThemeAppSize.width / 10,
          children: [
            Expanded(
              child: Obx(
                () => AnimatedContainer(
                  curve: Curves.easeOutBack,
                  duration: const Duration(milliseconds: 1500),
                  transform: Matrix4.translationValues(
                      0, _.startAnimationProfile.value ? 0 : 100, 0),
                  child: InkWell(
                    onTap: () => customShowDialog(widget: const FavoritePage()),
                    child: GetBuilder<FavoriteController>(
                      builder: (_) =>
                          achievementItem('favorite'.tr, _.getFavoriteList.length),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Obx(
                () => AnimatedContainer(
                  curve: Curves.easeOutBack,
                  duration: const Duration(milliseconds: 1850),
                  transform: Matrix4.translationValues(
                      0, _.startAnimationProfile.value ? 0 : 100, 0),
                  child: InkWell(
                    onTap: () => customShowDialog(widget: const HistoryPayProfile()),
                    child: GetBuilder<CartController>(
                      builder: (_) =>
                          achievementItem('buy'.tr, '${_.getHistoryList().length}'),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Obx(
                () => AnimatedContainer(
                  curve: Curves.easeOutBack,
                  duration: const Duration(milliseconds: 2200),
                  transform: Matrix4.translationValues(
                      0, _.startAnimationProfile.value ? 0 : 100, 0),
                  child: GetBuilder<CartController>(
                    builder: (_) => achievementItem('bought_on'.tr, '${_.totalPrice()}'),
                  ),
                ),
              ),
            )
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
      child: const Row(
        children: [
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

    final auth = Get.find<AuthController>();

    return InkWell(
      onTap: () => customShowDialog(
        widget: Padding(
          padding: EdgeInsets.all(ThemeAppSize.kInterval12),
          child: Wrap(
            spacing: ThemeAppSize.kInterval12,
            runSpacing: ThemeAppSize.kInterval12,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: context.width / 1.5,
                    child: SmallText(
                      height: 1.2,
                      text: 'Обновить данные о фотографии',
                      maxLines: 2,
                      size: ThemeAppSize.kFontSize18 * 1.5,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                      onTap: () => Get.back(),
                      child: Icon(Icons.close, color: context.theme.hintColor)),
                ],
              ),
              SizedBox(height: ThemeAppSize.kInterval12),
              MyTextField(textController: auth.cPhotoURL, text: 'URL'),
              SizedBox(height: ThemeAppSize.kInterval12),
              InkWell(
                onTap: () => auth.setImgUrl(),
                child: const MyButtonString(text: 'Применить'),
              ),
            ],
          ),
        ),
      ),
      child: WrapperIcon(
        colorBorder: context.theme.hintColor,
        bg: context.theme.scaffoldBackgroundColor,
        icon:
          Icons.image_search_rounded,

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
        icon:
          Icons.settings,

      ),
    );
  }
}
