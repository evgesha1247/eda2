import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:text/app/models/products_model.dart';
import 'package:text/app/widgets/icon/wrap_icon.dart';
import 'package:text/app/widgets/text/my_text.dart';

import '../../../../models/favorite_model.dart';
import '../../../../routes/main_routes.dart';
import '../../../../theme/theme_app.dart';
import 'controller/favorite_controller.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(ThemeAppSize.kInterval12),
      child: ListView(
        shrinkWrap: true,
        children: [
          const _HeaderFavorite(),
          SizedBox(height: ThemeAppSize.kInterval24),
          const _BodyFavorite(),
        ],
      ),
    );
  }
}

class _HeaderFavorite extends StatelessWidget {
  const _HeaderFavorite();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BigText(text: 'favorite', size: ThemeAppSize.kFontSize20 * 1.5),
        InkWell(
          onTap: () => Get.back(),
          child: WrapperIcon(
            colorBorder: context.theme.hintColor,
            icon: Icons.close,
          ),
        ),
      ],
    );
  }
}

class _BodyFavorite extends StatelessWidget {
  const _BodyFavorite();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavoriteController>(
      builder: (controller) {
        return ListView.separated(
          shrinkWrap: true,
          itemCount: controller.getFavoriteList.length,
          itemBuilder: (BuildContext context, int index) => _ItemBuilder(
            item: controller.getFavoriteList[index],
          ),
          separatorBuilder: (BuildContext context, int index) => SizedBox(
            height: ThemeAppSize.kInterval12,
          ),
        );
      },
    );
  }
}

class _ItemBuilder extends StatelessWidget {
  final FavoriteModel item;
  const _ItemBuilder({required this.item});
  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [_ItemInside(item: item.product)],
      ),
      child: GestureDetector(
        onTap: () => Get.toNamed(
          MainRoutes.getDetailed(item.product.id),
          arguments: item.product,
        ),
        child: Container(
          height: ThemeAppSize.kHeight100 + ThemeAppSize.kInterval24 * 2,
          padding: EdgeInsets.all(ThemeAppSize.kInterval24),
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.all(Radius.circular(ThemeAppSize.kRadius12)),
          ),
          child: Row(
            children: [
              _ItemImg(img: item.product.imgs?.first.imgURL as String),
              SizedBox(width: ThemeAppSize.kInterval12),
              _ItemInfo(item: item.product)
            ],
          ),
        ),
      ),
    );
  }
}

class _ItemInside extends StatelessWidget {
  final ProductModel item;
  const _ItemInside({required this.item});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FavoriteController>();
    return Flexible(
      child: Center(
        child: Container(
          height: ThemeAppSize.kInterval24 * 5,
          width: ThemeAppSize.kInterval24 * 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(ThemeAppSize.kRadius18),
            ),
            border: Border.all(color: context.theme.hintColor),
          ),
          child: Center(
            child: GestureDetector(
              onTap: () => controller.upDataFavoriteList(item),
              child: Icon(
                Icons.favorite,
                color: context.theme.primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ItemImg extends StatelessWidget {
  final String img;
  const _ItemImg({required this.img});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ThemeAppSize.kHeight100,
      height: ThemeAppSize.kHeight100,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(img),
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(ThemeAppSize.kRadius18),
        ),
      ),
    );
  }
}

class _ItemInfo extends StatelessWidget {
  final ProductModel item;
  const _ItemInfo({required this.item});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ThemeAppSize.kHeight100,
      width: ThemeAppSize.kHeight100 * 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(text: item.name.toString()),
          SizedBox(height: ThemeAppSize.kInterval12),
          Flexible(
            child: SmallText(text: item.description.toString(), maxLines: 3),
          ),
        ],
      ),
    );
  }
}
