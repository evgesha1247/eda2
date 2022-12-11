
import 'package:flutter/material.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import '../../../../utils/app_constants.dart';
import '../../../controllers/page_controller/menu_controller.dart';
import '../../../models/products_model.dart';
import '../../../routes/main_routes.dart';
import '../../../theme/theme_app.dart';
import '../../../widgets/icon/anumated_icon_favorit.dart';
import '../../../widgets/text/my_text.dart';

class MenuBody extends StatelessWidget {
  MenuBody({super.key});
    final controller = Get.find<MenuController>();
  Widget _builderItem(item) {
    return Padding(
        padding: EdgeInsets.only(
          left: ThemeAppSize.kInterval12,
          bottom: ThemeAppSize.kInterval24,
          right: ThemeAppSize.kInterval12,
        ),
        child: GestureDetector(
          onTap: () => Get.toNamed(
          MainRoutes.getDetailed(item.id),
          arguments: item,
          ),
          child: Stack(
            children: [
              _ItemImg(
                img:
                    "${AppConstansts.BASE_URL}/uploads/${item.img!}",
              ),
            _ItemControlElements(product: item),
            ],
          ),
        ),

    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MenuController>(
      builder: (_) => _.isListGrid
          ? SliverToBoxAdapter(
              child: EasyRefresh(
                header: const ClassicHeader(),
                footer: const ClassicFooter(),
                onRefresh: () async {},
                onLoad: () async {},
                child: SizedBox(
                  height: 1000,
                  child: GridView.builder(
                    itemCount: controller.filterList.length,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 370,
                    ),
                    itemBuilder: (context, index) =>
                        _builderItem(controller.filterList[index]),
                  ),
                ),
              ),
            )
          : ListView.builder(
              itemCount: controller.filterList.length,
              itemBuilder: (BuildContext context, int index) {
                return _builderItem(controller.filterList[index]);
              },
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
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: ThemeAppFun.decoration(),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(img),
        ),
      ),
    );
  }
}

class _ItemControlElements extends StatelessWidget {
  final ProductModel product;
  const _ItemControlElements({required this.product});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.all(ThemeAppSize.kInterval12),
          decoration: BoxDecoration(
            color: context.theme.cardColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(ThemeAppSize.kRadius12),
              bottomLeft: Radius.circular(ThemeAppSize.kRadius18),
            ),
          ),
          child: BigText(
            text: '\$${product.price}',
            color: ThemeMode.system == ThemeMode.dark
                ? context.theme.scaffoldBackgroundColor
                : context.theme.accentColor,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(ThemeAppSize.kInterval12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CartAddIcon(
                product: product,
                bg: context.theme.scaffoldBackgroundColor,
                iconColor: context.theme.hintColor,
              ),
              FavoritIcon(
                product: product,
                bg: context.theme.scaffoldBackgroundColor,
                iconColor: context.theme.hintColor,
              )
            ],
          ),
        )
      ],
    );
  }
}
