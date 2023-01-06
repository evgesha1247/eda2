// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/models/products_model.dart';
import 'package:text/app/routes/main_routes.dart';
import 'package:text/app/widgets/icon/anumated_icon_favorit.dart';
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
          size: ThemeAppSize.kFontSize18,
        ),
        const BigText(text: '•'),
        SmallText(
          text: 'Food pairing',
          size: ThemeAppSize.kFontSize16,
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
    return GetBuilder<ProductController>(
      builder: (recommendedProduct) {
        return ListView.builder(
          itemCount: recommendedProduct.recommendedProductList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            var selected = false.obs;
            final ProductModel item =
                recommendedProduct.recommendedProductList[index];
            return GestureDetector(
                onTap: () => selected(!selected.value),
                onLongPress: () => Get.toNamed(
                      MainRoutes.getDetailed(item.id),
                      arguments: item,
                    ),
                child: _Item(selected: selected, item: item, index: index)
                // Obx(
                //   () => selected.value
                //       ? _ItemOpen(item: item)
                //       : _ItemClos(item: item, index: index),
                // ),
                );
          },
        );
      },
    );
  }
}

class _Item extends StatelessWidget {
  final RxBool selected;
  final ProductModel item;
  final int index;
  const _Item(
      {required this.selected, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    final maxHeight = ThemeAppSize.kHeight100 * 1.5;
    final minHeight = ThemeAppSize.kHeight100 + ThemeAppSize.kInterval12;
    final widthDivider = ThemeAppSize.kHeight75 - ThemeAppSize.kInterval12;
    const durationWrapBox = Duration(milliseconds: 300);

    return Obx(
      () {
        final imgSize = selected.value
            ? ThemeAppSize.kHeight100 + ThemeAppSize.kInterval12
            : ThemeAppSize.kHeight100;
        final widthInfo = selected.value
            ? context.width - ThemeAppSize.kInterval24
            : context.width - widthDivider - ThemeAppSize.kInterval24;
        return AnimatedContainer(
          duration: durationWrapBox,
          height: selected.value ? maxHeight : minHeight,
          child: Stack(
            alignment: AlignmentDirectional.centerStart,
            children: [
              ///
              /// info
              ///
              ///

              AnimatedContainer(
                duration: durationWrapBox,
                height:
                    selected.value ? maxHeight : ThemeAppSize.kHomeListViewInfo,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(
                    left: ThemeAppSize.kInterval12 + imgSize,
                    top: ThemeAppSize.kInterval12,
                    right: ThemeAppSize.kInterval12,
                    bottom: ThemeAppSize.kInterval12),
                width: widthInfo,
                decoration: BoxDecoration(
                  color: context.theme.cardColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(ThemeAppSize.kRadius18),
                  ),
                ),
                child: Stack(
                  children: [
                    AnimatedAlign(
                      duration: durationWrapBox,
                      curve: Curves.easeInOut,
                      alignment: selected.value
                          ? Alignment.topCenter
                          : Alignment.centerLeft,
                      child: BigText(
                        size: ThemeAppSize.kFontSize18,
                        text: item.name!,
                        maxLines: 2,
                        color: context.theme.accentColor,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: AnimatedOpacity(
                        opacity: selected.value ? 0.6 : 0,
                        duration: durationWrapBox,
                        child: SmallText(
                          text: item.description.toString(),
                          maxLines: 2,
                          size: ThemeAppSize.kFontSize18,
                          color: context.theme.accentColor,
                        ),
                      ),
                    ),
                    AnimatedOpacity(
                      duration: durationWrapBox,
                      opacity: selected.value ? 1 : 0,
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: FavoritIcon(
                              product: item,
                              fun: selected.value ? null : () {},
                              iconColor: context.theme.accentColor,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 30,
                            child: CartAddIcon(
                              product: item,
                              fun: selected.value ? null : () {},
                              iconColor: context.theme.accentColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              ///
              /// img
              ///

              Align(
                alignment: Alignment.bottomLeft,
                child: AnimatedOpacity(
                  opacity: selected.value ? 0.6 : 0,
                  duration: durationWrapBox,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: ThemeAppSize.kInterval5 * 3,
                      left: imgSize / 2 - ThemeAppSize.kInterval24,
                    ),
                    child: SmallText(
                      text: '\$ ${item.price}',
                      maxLines: 1,
                      size: ThemeAppSize.kFontSize20,
                      color: context.theme.accentColor,
                    ),
                  ),
                ),
              ),

              AnimatedAlign(
                duration: durationWrapBox,
                curve: Curves.easeInOut,
                alignment:
                    selected.value ? Alignment.topLeft : Alignment.centerLeft,
                child: AnimatedContainer(
                  duration: durationWrapBox,
                  curve: Curves.fastOutSlowIn,
                  width: imgSize,
                  height: selected.value
                      ? imgSize - ThemeAppSize.kInterval12
                      : imgSize,
                  decoration: BoxDecoration(
                    color: context.theme.cardColor,
                    borderRadius: selected.value
                        ? BorderRadius.only(
                            bottomRight: Radius.circular(
                              ThemeAppSize.kRadius18,
                            ),
                            topLeft: Radius.circular(
                              ThemeAppSize.kRadius18,
                            ),
                          )
                        : ThemeAppFun.decoration(
                            radius: ThemeAppSize.kRadius18),
                    image: DecorationImage(
                      image: NetworkImage(
                        item.img!,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              ///
              /// divider
              ///

              Align(
                alignment: Alignment.centerRight,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: selected.value ? 0 : 1,
                  child: SizedBox(
                    width: widthDivider,
                    child: Column(
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
                          child: Center(child: BigText(text: '$index')),
                        ),
                        Expanded(
                          child: Container(
                            width: 2,
                            color: context.theme.cardColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 100, color: color),
        BigText(text: text, color: color)
      ],
    );
  }
}
