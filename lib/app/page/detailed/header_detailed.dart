import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/models/products_model.dart';
import 'package:text/app/widgets/text/my_text.dart';
import '../../../utils/app_constants.dart';
import '../../controllers/popular_product_controller.dart';
import '../../routes/main_routes.dart';
import '../../theme/theme_app.dart';
import '../../widgets/icon/menu_icon.dart';

class HeaderDetailed extends StatelessWidget {
  const HeaderDetailed({super.key, required this.item});
  final ProductModel item;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: true,
      backgroundColor: ThemeAppColor.kFrontColor,
      surfaceTintColor: ThemeAppColor.kFrontColor,
      expandedHeight: 280,
      collapsedHeight: 120,
      toolbarHeight: 100,
      excludeHeaderSemantics: true,
      titleSpacing: ThemeAppSize.kInterval24,
      title: const _HeaderIcons(),
      flexibleSpace: _HeaderImg(img: item.img!),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(-5),
        child: _BodyTitle(name: item.name!),
      ),
    );
  }
}

class _HeaderImg extends StatelessWidget {
  const _HeaderImg({required this.img});
  final String img;
  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      background: Image.network(
        "${AppConstansts.BASE_URL}/uploads/$img",
        width: double.maxFinite,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _HeaderIcons extends StatelessWidget {
  const _HeaderIcons();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: CustomButtonIcon(
            sizePading: ThemeAppSize.kInterval12,
            icon: const Icon(Icons.arrow_back_ios_new),
            bg: ThemeAppColor.kBGColor,
          ),
        ),
        GetBuilder<PopularProductController>(
          builder: (_) {
            return GestureDetector(
              onTap: () => Get.toNamed(MainRoutes.getCart()),
              child: CustomButtonIcon(
                sizePading: ThemeAppSize.kInterval12,
                icon: _.totalItems >= 1
                    ? Row(children: [
                        const Icon(Icons.shopping_bag_rounded),
                        SmallText(
                            text: '${_.totalItems}',
                            color: ThemeAppColor.kFrontColor)
                      ])
                    : const Icon(Icons.shopping_bag_outlined),
                bg: ThemeAppColor.kBGColor,
              ),
            );
          },
        )
      ],
    );
  }
}

class _BodyTitle extends StatelessWidget {
  const _BodyTitle({required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ThemeAppColor.kBGColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(ThemeAppSize.kRadius20 * 2),
        ),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: ThemeAppSize.kInterval12),
          child: BigText(
            text: name,
            color: ThemeAppColor.kFrontColor,
            size: ThemeAppSize.kFontSize25,
          ),
        ),
      ),
    );
  }
}
