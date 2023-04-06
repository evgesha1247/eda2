// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/favorite_controller.dart';
import '../../../../models/products_model.dart';
import '../../../../routes/main_routes.dart';
import '../../../../theme/theme_app.dart';
import '../../../../widgets/text/my_text.dart';

class FavoriteSection extends StatelessWidget {
  const FavoriteSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _TitleFavorite(),
        SizedBox(height: ThemeAppSize.kInterval12),
        const _BodyFavorite(),
      ],
    );
  }
}

class _TitleFavorite extends StatelessWidget {
  const _TitleFavorite({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BigText(text: 'favorites'.tr),
        SmallText(text: 'see all', color: context.theme.primaryColor),
      ],
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
                _ItemBuilder(item: _.getFavoriteList[index].product),
            separatorBuilder: (BuildContext context, int index) => SizedBox(
              width: ThemeAppSize.kInterval24,
            ),
          );
        },
      ),
    );
  }
}



class _ItemBuilder extends StatelessWidget {
  const _ItemBuilder({required this.item});
  final ProductModel item;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
        )
    );
  }
}
