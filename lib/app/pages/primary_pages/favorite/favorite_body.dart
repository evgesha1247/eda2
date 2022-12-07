import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/app_constants.dart';
import '../../../controllers/favorite_controller.dart';
import '../../../models/products_model.dart';
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
          color: Get.theme.cardColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: GetBuilder<FavoriteController>(
          builder: (_) {
            return ListView.separated(
              itemCount: _.getFavoriteList.length,
              itemBuilder: (BuildContext context, int index) =>
                  _BuilderItem(item: _.getFavoriteList[index].product!),
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
    return Container(
      height: ThemeAppSize.kInterval24 * 7,
      decoration: BoxDecoration(
        color: Get.theme.backgroundColor,
        borderRadius: BorderRadius.all(
          Radius.circular(ThemeAppSize.kInterval12),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _ItemImg(img: '${AppConstansts.BASE_URL}/uploads/${item.img!}'),
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
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(ThemeAppSize.kInterval12),
          child: BigText(text: item.name!, maxLines: 2),
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
      child: Image(image: NetworkImage(img), fit: BoxFit.cover),
    );
  }
}
