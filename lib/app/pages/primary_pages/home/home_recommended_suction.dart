import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/models/products_model.dart';
import 'package:text/app/routes/main_routes.dart';
import 'package:text/app/widgets/icon/anumated_icon_favorit.dart';
import '../../../../utils/app_constants.dart';
import '../../../controllers/product_controller.dart';
import '../../../theme/theme_app.dart';
import '../../../widgets/load/circular.dart';
import '../../../widgets/text/my_text.dart';

class HomeRecommended extends StatelessWidget {
  const HomeRecommended({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ThemeAppSize.kInterval12),
      child: Column(
        children: [
          const _RecommendedTitle(),
          SizedBox(height: ThemeAppSize.kInterval12),
          const _RecommendedBody(),
        ],
      ),
    );
  }
}

class _RecommendedTitle extends StatelessWidget {
  const _RecommendedTitle({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BigText(
          text: 'Top recommended',
          size: ThemeAppSize.kFontSize20,
        ),
        SizedBox(width: ThemeAppSize.kInterval5),
        SmallText(
          text: '• Food pairing',
          size: ThemeAppSize.kFontSize18,
        ),
      ],
    );
  }
}

class _RecommendedBody extends StatelessWidget {
  const _RecommendedBody({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      builder: (product) {
        switch (product.recommendedStatusLoad) {
          case ProductStatusLoad.loading:
            return const CircularWidget();
          case ProductStatusLoad.error:
            return _ErrorLoadRecommended(controller: product);
          case ProductStatusLoad.received:
            return const _ItemBuilder();
        }
      },
    );
  }
}

class _ItemBuilder extends StatelessWidget {
  const _ItemBuilder();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height / 1.5,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: GetBuilder<ProductController>(
              builder: (recommendedProduct) {
                return ListView.builder(
                  itemCount: recommendedProduct.recommendedProductList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    var selected = true.obs;
                    final ProductModel item =
                        recommendedProduct.recommendedProductList[index];
                    return GestureDetector(
                      onTap: () => selected(!selected.value),
                      onLongPress: () => Get.toNamed(
                        MainRoutes.getDetailed(item.id),
                        arguments: item,
                      ),
                      child: Obx(
                        () => selected.value
                            ? _ItemOpen(item: item, index: index)
                            : _ItemClos(item: item),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _ItemOpen extends StatelessWidget {
  final ProductModel item;
  final int index;
  const _ItemOpen({required this.item, required this.index});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ThemeAppSize.kHomeListView,
      child: Row(
        children: [
          Container(
            width: ThemeAppSize.kHomeListView,
            height: ThemeAppSize.kHomeListView,
            decoration: BoxDecoration(
              borderRadius: ThemeAppFun.decoration(
                radius: ThemeAppSize.kRadius18,
              ),
              image: DecorationImage(
                image: NetworkImage(
                  "${AppConstansts.BASE_URL}/uploads/${item.img!}",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: ThemeAppSize.kHomeListViewInfo,
              decoration: BoxDecoration(
                color: Get.context?.theme.cardColor,
                borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(ThemeAppSize.kRadius12),
                ),
              ),
              child: BigText(
                text: item.name!,
                maxLines: 2,
                color: Get.context!.theme.accentColor,
              ),
            ),
          ),
          SizedBox(width: ThemeAppSize.kInterval24),
          Column(
            children: [
              Expanded(
                child: Container(
                  width: 2,
                  color: context.theme.cardColor,
                ),
              ),
              Container(
                width: ThemeAppSize.kInterval24 * 1.5,
                height: ThemeAppSize.kInterval24 * 1.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(ThemeAppSize.kRadius18),
                  ),
                  border: Border.all(
                    color: context.theme.cardColor,
                  ),
                ),
                child: Center(child: BigText(text: '${index + 1}')),
              ),
              Expanded(
                child: Container(
                  width: 2,
                  color: context.theme.cardColor,
                ),
              ),
            ],
          ),
          SizedBox(width: ThemeAppSize.kInterval24)
        ],
      ),
    );
  }
}

class _ItemClos extends StatelessWidget {
  final ProductModel item;
  const _ItemClos({required this.item});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ThemeAppSize.kHomeListView,
      decoration: BoxDecoration(
        color: Get.context?.theme.cardColor,
        borderRadius: BorderRadius.all(Radius.circular(ThemeAppSize.kRadius18)),
      ),
      clipBehavior: Clip.hardEdge,
      child: Row(
        children: [
          Image(
            width: ThemeAppSize.kHomeListView,
            height: ThemeAppSize.kHomeListView,
            fit: BoxFit.cover,
            image: NetworkImage(
              "${AppConstansts.BASE_URL}/uploads/${item.img!}",
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(ThemeAppSize.kInterval12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BigText(
                    text: item.name!,
                    maxLines: 2,
                    color: Get.context!.theme.accentColor,
                  ),
                  SmallText(
                    maxLines: 2,
                    text: item.description!,
                    color: Get.context!.theme.accentColor.withOpacity(0.8),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BigText(
                        text: '${item.price!.toStringAsFixed(2)}\$',
                        maxLines: 2,
                        color: Get.context!.theme.accentColor,
                      ),
                      const Spacer(),
                      CartAddIcon(
                        product: item,
                        statusBorder: true,
                      ),
                      SizedBox(
                        width: ThemeAppSize.kInterval12,
                      ),
                      FavoritIcon(
                        product: item,
                        statusBorder: true,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorLoadRecommended extends StatelessWidget {
  final ProductController controller;
  const _ErrorLoadRecommended({required this.controller});
  @override
  Widget build(BuildContext context) {
    return AnimatedIconWidget(
      currIndex:
          (controller.popularStatusLoad == ProductStatusLoad.error ? 0 : 1).obs,
      fun: () => controller.getDataProduct(),
      widget1: const _IconError(
        icon: Icons.wifi_off,
        text: 'no connection',
      ),
      widget2: const _IconError(
        icon: Icons.arrow_circle_down_outlined,
        text: 'connection . . . ',
      ),
    );
  }
}

class _IconError extends StatelessWidget {
  final IconData icon;
  final String text;
  const _IconError({required this.icon, required this.text});
  @override
  Widget build(BuildContext context) {
    final color = ThemeMode.system == ThemeMode.dark
        ? context.theme.cardColor.withOpacity(0.5)
        : context.theme.cardColor.withOpacity(.6);
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 100, color: color),
          BigText(text: text, color: color)
        ],
      ),
    );
  }
}
