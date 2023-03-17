// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/widgets/icon/anumated_icon.dart';
import 'controller/favorite_controller.dart';
import '../../../../models/products_model.dart';
import '../../../../routes/main_routes.dart';
import '../../../../theme/theme_app.dart';
import '../../../../widgets/text/my_text.dart';

class FavoriteBody extends StatelessWidget {
  const FavoriteBody({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ThemeAppSize.kHeight100,
      child: GetBuilder<FavoriteController>(
        builder: (_) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _.getFavoriteList.length,
            itemBuilder: (BuildContext context, int index) =>
                _BuilderItem(item: _.getFavoriteList[index].product),
          );
        },
      ),
    );
  }
}

class _BuilderItem extends StatelessWidget {
  const _BuilderItem({required this.item});
  final ProductModel item;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(
        MainRoutes.getDetailed(item.id),
        arguments: item,
      ),
      child: Image(
        width: ThemeAppSize.kHeight100,
        height: ThemeAppSize.kHeight100,
        image: NetworkImage(item.imgs?.first.imgURL as String),
        fit: BoxFit.cover,
      ),
    );
  }
}
