import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/models/products_model.dart';
import 'package:text/app/theme/theme_app.dart';
import 'package:text/app/widgets/text/my_text.dart';

import '../../../utils/app_constants.dart';
import '../../controllers/favorite_controller.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeAppColor.kFrontColor,
      body: Column(
        children: const [
          _HeaderFavoritWidget(),
          _GridViewWidget(),
        ],
      ),
    );
  }
}

class _HeaderFavoritWidget extends StatelessWidget {
  const _HeaderFavoritWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(ThemeAppSize.kInterval12),
          child: const BigText(
            text: 'Favorites',
            color: ThemeAppColor.kBGColor,
          ),
        ),
        Icon(
          Icons.favorite_border_outlined,
          color: ThemeAppColor.kBGColor,
          size: ThemeAppSize.kFontSize22,
        )
      ],
    );
  }
}

class _GridViewWidget extends StatelessWidget {
  const _GridViewWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: ThemeAppSize.kInterval24),
        decoration: const BoxDecoration(
          color: ThemeAppColor.kBGColor,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: GetBuilder<FavoriteController>(
          builder: (_) {
            return ListView.separated(
              itemCount: _.favoriteList.length,
              itemBuilder: (BuildContext context, int index) =>
                  _ItemBuilder(item: _.favoriteList[index]),
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

class _ItemBuilder extends StatelessWidget {
  const _ItemBuilder({required this.item});
  final ProductModel item;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ThemeAppSize.kInterval24 * 7,
      decoration: BoxDecoration(
        color: ThemeAppColor.kFrontColor,
        borderRadius: BorderRadius.all(
          Radius.circular(ThemeAppSize.kInterval12),
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _ItemImg(img: '${AppConstansts.BASE_URL}/uploads/${item.img!}'),
          SizedBox(width: ThemeAppSize.kInterval12),
          _ItemInfo(item: item),
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
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(ThemeAppSize.kInterval12),
        child: BigText(
          text: item.name!,
          maxLines: 2,
        ),
      ),
    );
  }
}

class _ItemImg extends StatelessWidget {
  const _ItemImg({required this.img});
  final String img;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Image(
        image: NetworkImage(img),
        fit: BoxFit.cover,
        alignment: Alignment.center,
      ),
    );
  }
}
