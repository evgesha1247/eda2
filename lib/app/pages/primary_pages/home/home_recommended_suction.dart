// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/models/products_model.dart';
import 'package:text/app/widgets/icon/anumated_icon.dart';
import '../../../controllers/product_controller.dart';
import '../../../theme/theme_app.dart';
import '../../../widgets/animation/anim_scale.dart';
import '../../../widgets/load/circular.dart';
import '../../../widgets/text/my_text.dart';

class HomeRecommended extends StatelessWidget {
  const HomeRecommended({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      builder: (controller) {
        switch (controller.recommendedStatusLoad) {
          case ProductStatusLoad.loading:
            return const CircularWidget();
          case ProductStatusLoad.error:
            return const _ErrorLoadWidget();
          case ProductStatusLoad.received:
            return const _SuccessfulDownload();
        }
      },
    );
  }
}

class _SuccessfulDownload extends StatelessWidget {
  const _SuccessfulDownload();
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
          text: 'top_recommended'.tr,
          size: ThemeAppSize.kFontSize18,
        ),
      ],
    );
  }
}

class _RecommendedBody extends StatelessWidget {
  const _RecommendedBody();
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductController>();
    return ListView.separated(
      itemCount: controller.recommendedProductList.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Obx(
          () => AnimatedContainer(
            curve: Curves.easeInOut,
            duration: Duration(milliseconds: 350 + (index * 300)),
            transform: Matrix4.translationValues(
                controller.startAnimation.value ? 0 : context.width, 0, 0),
            child: _ItemBuild(
              item: controller.recommendedProductList[index],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => SizedBox(
        height: ThemeAppSize.kInterval12,
      ),
    );
  }
}

class _ItemBuild extends StatefulWidget {
  final ProductModel item;
  const _ItemBuild({required this.item});
  @override
  _ItemBuildState createState() => _ItemBuildState();
}

class _ItemBuildState extends State<_ItemBuild>
    with SingleTickerProviderStateMixin {
  late final AnimationController expandController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );
  late final Animation<double> animation = CurvedAnimation(
    parent: expandController,
    curve: Curves.easeOutBack,
  );
  RxBool expand = false.obs;
  void _runExpandCheck() {
    expand.value = !expand.value;
    expand.value ? expandController.forward() : expandController.reverse();
  }

  Widget hiding(Widget widget) {
    return SizeTransition(
      axisAlignment: 1.0,
      sizeFactor: animation,
      child: widget,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _runExpandCheck(),
      child: Container(
        color: context.theme.cardColor,
        padding: EdgeInsets.all(ThemeAppSize.kInterval12),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ItemImg(
                  img: widget.item.imgs?.first.imgURL as String,
                  select: expand,
                ),
                hiding(
                  Column(
                    children: [
                      SizedBox(height: ThemeAppSize.kInterval5),
                      _ItemPrice(
                        price: widget.item.price.toString(),
                        select: expand,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(width: ThemeAppSize.kInterval12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ItemName(name: widget.item.name as String),
                  hiding(
                    Column(
                      children: [
                        SizedBox(height: ThemeAppSize.kInterval5),
                        _ItemDescription(
                          description: widget.item.description as String,
                        ),
                        SizedBox(height: ThemeAppSize.kInterval24),
                        _ItemButton(
                          item: widget.item,
                          select: expand,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //     const _ItemDivider(),
          ],
        ),
      ),
    );
  }
}

class _ItemName extends StatelessWidget {
  final String name;
  const _ItemName({required this.name});
  @override
  Widget build(BuildContext context) {
    return BigText(
      text: name,
      color: context.theme.accentColor,
      size: ThemeAppSize.kFontSize16 * 1.4,
    );
  }
}

class _ItemButton extends StatelessWidget {
  final ProductModel item;
  final RxBool select;
  const _ItemButton({required this.item, required this.select});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimationScaleWidget(
          widget: CartAddIcon(product: item),
          select: select,
        ),
        SizedBox(width: ThemeAppSize.kInterval12),
        AnimationScaleWidget(
          durationMilliseconds: 1750,
          widget: FavoritIcon(product: item),
          select: select,
        ),
      ],
    );
  }
}

class _ItemPrice extends StatelessWidget {
  final String price;
  final RxBool select;
  const _ItemPrice({required this.price, required this.select});
  @override
  Widget build(BuildContext context) {
    return AnimationScaleWidget(
      select: select,
      widget: SizedBox(
        width: ThemeAppSize.kHeight100,
        child: Center(
          child: SmallText(
            text: 'Price  $price \$',
            color: context.theme.accentColor,
          ),
        ),
      ),
    );
  }
}

class _ItemDescription extends StatelessWidget {
  final String description;
  const _ItemDescription({required this.description});
  @override
  Widget build(BuildContext context) {
    return BigText(
      maxLines: 3,
      size: ThemeAppSize.kFontSize16,
      text: description,
      color: context.theme.accentColor,
    );
  }
}

class _ItemImg extends StatelessWidget {
  final String img;
  final RxBool select;
  const _ItemImg({required this.img, required this.select});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final size =
          !select.value ? ThemeAppSize.kHeight75
          : ThemeAppSize.kHeight100;
      return AnimatedContainer(
        width: !select.value ? size : size,
        height: !select.value ? size : size * 1.3,
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: context.theme.cardColor,
          borderRadius: ThemeAppFun.decoration(
              radius: !select.value
                  ? ThemeAppSize.kRadius18
                  : ThemeAppSize.kRadius12),
          image: DecorationImage(
            image: NetworkImage(img),
            fit: BoxFit.cover,
          ),
        ),
      );
    });
  }
}

class _ItemDivider extends StatelessWidget {
  const _ItemDivider();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 2,
          color: Colors.red,
        ),
        Container(
          width: ThemeAppSize.kInterval24 * 1.5,
          height: ThemeAppSize.kInterval24 * 1.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(ThemeAppSize.kRadius18),
            ),
            border: Border.all(color: Colors.red),
          ),
          child: Center(child: BigText(text: '${1}')),
        ),
        Container(
          width: 2,
          color: Colors.red,
        ),
      ],
    );
  }
}

///// error !!! ////
class _ErrorLoadWidget extends StatelessWidget {
  const _ErrorLoadWidget();
  @override
  Widget build(BuildContext context) {
    final color = ThemeMode.system == ThemeMode.dark
        ? context.theme.cardColor.withOpacity(0.5)
        : context.theme.cardColor.withOpacity(.6);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.wifi_off, size: 100, color: color),
        BigText(text: 'no connection', color: color)
      ],
    );
  }
}
