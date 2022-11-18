import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/models/products_model.dart';
import 'package:text/app/routes/main_routes.dart';

import '../../../utils/app_constants.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../theme/theme_app.dart';
import '../../widgets/load/circular_widget.dart';
import '../../widgets/text/my_text.dart';

class RecommendedSuction extends StatelessWidget {
  const RecommendedSuction({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ThemeAppSize.kInterval24),
      child: Column(
        children: [
          const _RecommendedTitleWidget(),
          SizedBox(height: ThemeAppSize.kInterval12),
          _RecommendedListBuilderWidget(),
        ],
      ),
    );
  }
}

class _RecommendedTitleWidget extends StatelessWidget {
  const _RecommendedTitleWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const BigText(
          text: 'Recommended',
          color: ThemeAppColor.kFrontColor,
          size: 25,
        ),
        SizedBox(width: ThemeAppSize.kInterval5),
        SmallText(
          text: '• Food pairing',
          size: ThemeAppSize.kFontSize22,
          color: ThemeAppColor.kFrontColor.withOpacity(0.5),
        ),
      ],
    );
  }
}

class _RecommendedListBuilderWidget extends StatelessWidget {
  _RecommendedListBuilderWidget({Key? key}) : super(key: key);
  final recommendedProduct = Get.find<RecommendedProductController>();
  @override
  Widget build(BuildContext context) {
    Widget itemPopular(ProductModel item) {

      var selected = false.obs;
      final imgUrl = "${AppConstansts.BASE_URL}/uploads/${item.img!}";
      return GestureDetector(
        onTap: () => selected.value = !selected.value,
        onDoubleTap: () => Get.toNamed(
          MainRoutes.getDetailedFood(item.id),
          arguments: item,
        ),
        child: Obx(
          () => Stack(
            children: [
              Positioned(
                bottom: selected.value ? null : ThemeAppSize.kInterval12,
                top: selected.value ? null : ThemeAppSize.kInterval12,
                left: selected.value ? null : 0,
                right: selected.value ? null : 30,
                child: Container(
                  height: ThemeAppSize.kListViewImgSize,
                  padding: EdgeInsets.only(
                      left: ThemeAppSize.kListViewImgSize +
                          ThemeAppSize.kInterval12),
                  decoration: BoxDecoration(
                    color: ThemeAppColor.kFrontColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(ThemeAppSize.kRadius20),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(ThemeAppSize.kInterval12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        BigText(text: item.name!),
                        SizedBox(height: ThemeAppSize.kInterval12),
                        SmallText(
                          maxLines: 3,
                          text: !selected.value
                              ? '${item.price!}\$'
                              : item.description!,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Positioned(
                top: selected.value ? ThemeAppSize.kInterval12 : null,
                bottom: selected.value ? ThemeAppSize.kInterval12 : null,
                left: selected.value ? ThemeAppSize.kInterval12 : null,
                child: Container(
                  width: ThemeAppSize.kListViewImgSize,
                  height: ThemeAppSize.kListViewImgSize,
                  decoration: BoxDecoration(
                    color: ThemeAppColor.kAccent2,
                    borderRadius: ThemeAppFun.decoration(),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(imgUrl),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SizedBox(
      height: context.height / 1.8,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: GetBuilder<RecommendedProductController>(
                builder: (recommendedProduct) {
                  return recommendedProduct.isLoaded
                      ? ListView.separated(
                          itemCount:
                              recommendedProduct.recommendedProductList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) =>
                              itemPopular(
                            recommendedProduct.recommendedProductList[index],
                          ),
                          separatorBuilder: (BuildContext context, int index) =>
                              SizedBox(height: ThemeAppSize.kInterval12),
                        )
                      : const CircularWidget();
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
