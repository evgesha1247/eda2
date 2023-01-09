// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/widgets/icon/anumated_icon_favorit.dart';
import '../../../controllers/page_controller/favorite_controller.dart';
import '../../../models/products_model.dart';
import '../../../routes/main_routes.dart';
import '../../../theme/theme_app.dart';
import '../../../widgets/text/my_text.dart';

class FavoriteBody extends StatelessWidget {
  const FavoriteBody({super.key});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(
          top: ThemeAppSize.kInterval24,
          left: ThemeAppSize.kInterval24,
          right: ThemeAppSize.kInterval24,
        ),
        decoration: BoxDecoration(
          color: context.theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(ThemeAppSize.kRadius18 * 2),
          ),
        ),
        child: GetBuilder<FavoriteController>(
          builder: (_) {
            return ListView.separated(
              itemCount: _.getFavoriteList.length,
              itemBuilder: (BuildContext context, int index) =>
                  _BuilderItem(item: _.getFavoriteList[index].product),
              separatorBuilder: (BuildContext context, int index) => SizedBox(
                height: ThemeAppSize.kInterval12,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _BuilderItem extends StatelessWidget {
  const _BuilderItem({required this.item});
  final ProductModel item;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ThemeAppSize.kHeight75 * 1.8,

      child: Stack(
        children: [
          _ItemInfo(item: item),
          _ItemImg(item: item),
        ],
      ),
    );

  }
}

class _ItemInfo extends StatelessWidget {
  const _ItemInfo({required this.item});
  final ProductModel item;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: ThemeAppSize.kHeight100 / 2,
      top: 0,
      bottom: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.only(
          left: ThemeAppSize.kHeight100 / 2 + ThemeAppSize.kInterval12,
        ),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: context.theme.cardColor,
          borderRadius: BorderRadius.circular(ThemeAppSize.kRadius18),
        ),
        clipBehavior: Clip.hardEdge,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BigText(
              text: item.name!,
              maxLines: 2,
              color: context.theme.accentColor,
            ),
            SizedBox(height: ThemeAppSize.kInterval12),
            Row(
              children: [
                SmallText(
                  text: ' ${item.price} \$',
                  color: context.theme.accentColor,
                ),
                SizedBox(width: ThemeAppSize.kInterval12),
                CartAddIcon(
                  product: item,
                  statusBorder: true,
                  iconColor: context.theme.accentColor,
                ),
              ],
            )
          ],
        ),

      ),
    );
  }
}

class _ItemImg extends StatelessWidget {
  const _ItemImg({required this.item});
  final ProductModel item;
  @override
  Widget build(BuildContext context) {

    return Positioned(
      top: (ThemeAppSize.kHeight75 * 1.8 - ThemeAppSize.kHeight100) / 2,
      child: GestureDetector(
        onTap: () => Get.toNamed(
          MainRoutes.getDetailed(item.id),
          arguments: item,
        ),
        child: Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ThemeAppSize.kRadius18),
          ),
          clipBehavior: Clip.hardEdge,
          child: Hero(
            tag: 'page2${item.imgs?.first.imgURL}',
            child: Image(
              width: ThemeAppSize.kHeight100,
              height: ThemeAppSize.kHeight100,
              image: NetworkImage(item.imgs?.first.imgURL as String),
              fit: BoxFit.cover,
            ),
          ),

        ),
      ),
    );
  }
}
