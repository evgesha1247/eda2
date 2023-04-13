import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/widgets/animation/anim_scale.dart';
import '../../guiding/controller/guiding_controller.dart';
import 'controller/favorite_controller.dart';
import '../../../../models/products_model.dart';
import '../../../../routes/main_routes.dart';
import '../../../../theme/theme_app.dart';
import '../../../../widgets/text/my_text.dart';

class FavoriteSection extends StatelessWidget {
  const FavoriteSection({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavoriteController>(
      builder: (_) {
        return Column(
          children: _.getFavoriteList.isNotEmpty
              ? [
                  const _TitleFavorite(),
                  SizedBox(height: ThemeAppSize.kInterval12),
                  const _BodyFavorite(),
                  SizedBox(height: ThemeAppSize.kInterval12),
                ]
              : [],
        );
      },
    );
  }
}

class _TitleFavorite extends StatelessWidget {
  const _TitleFavorite({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GuidingController>();

    return AnimationScaleWidget(
      durationMilliseconds: 1750,
      select: controller.startAnimationProfile,
      widget: Padding(
        padding: EdgeInsets.symmetric(horizontal: ThemeAppSize.kInterval24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BigText(text: 'favorites'.tr),
            SmallText(text: 'see all', color: context.theme.primaryColor),
          ],
        ),
      ),
    );
  }
}

class _BodyFavorite extends StatelessWidget {
  const _BodyFavorite();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ThemeAppSize.kHeight100,
      child: GetBuilder<FavoriteController>(
        builder: (_) {
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _.getFavoriteList.length,
            itemBuilder: (BuildContext context, int index) =>
                _ItemBuilder(item: _.getFavoriteList[index].product, index: index),
            separatorBuilder: (BuildContext context, int index) => SizedBox(
              width: ThemeAppSize.kInterval12,
            ),
          );
        },
      ),
    );
  }
}

class _ItemBuilder extends StatelessWidget {
  final int index;
  const _ItemBuilder({required this.item, required this.index});
  final ProductModel item;
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GuidingController>();

    return Obx(() => AnimatedContainer(
          curve: Curves.easeInOutBack,
          duration: Duration(milliseconds: 1350 + (index * 350)),
          transform: Matrix4.translationValues(
              controller.startAnimationProfile.value ? 0 : context.width, 0, 0),
          child: GestureDetector(
              onTap: () => Get.toNamed(
                    MainRoutes.getDetailed(item.id),
                    arguments: item,
                  ),
              child: Container(
                width: ThemeAppSize.kHeight100,
                height: ThemeAppSize.kHeight100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(item.imgs?.first.imgURL as String),
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(ThemeAppSize.kInterval12),
                  ),
                ),
              )),
        ));
  }
}
