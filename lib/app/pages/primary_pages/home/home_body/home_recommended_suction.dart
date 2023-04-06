// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/models/products_model.dart';
import 'package:text/app/widgets/icon/anumated_icon.dart';
import '../../../../controllers/product_controller.dart';
import '../../../../routes/main_routes.dart';
import '../../../../theme/theme_app.dart';
import '../../../../widgets/animation/anim_scale.dart';
import '../../../../widgets/load/circular.dart';
import '../../../../widgets/text/my_text.dart';

class RecommendedHome extends StatelessWidget {
  const RecommendedHome({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      builder: (controller) {
        switch (controller.recommendedStatusLoad) {
          case ProductStatusLoad.loading:
            return const CircularWidget();
          case ProductStatusLoad.error:
            return const _ErrorLoadRecommended();
          case ProductStatusLoad.received:
            return const _GoodLoadRecommended();
        }
      },
    );
  }
}

///// Error Widget ////
class _ErrorLoadRecommended extends StatelessWidget {
  const _ErrorLoadRecommended();
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
        BigText(text: 'no connection', color: color),
      ],
    );
  }
}

//// Good Widget ////
class _GoodLoadRecommended extends StatelessWidget {
  const _GoodLoadRecommended();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ThemeAppSize.kInterval12),
      child: Column(
        children: [
          const _TitleRecommended(),
          SizedBox(height: ThemeAppSize.kInterval12),
          const _BodyRecommended(),
        ],
      ),
    );
  }
}

class _TitleRecommended extends StatelessWidget {
  const _TitleRecommended({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [BigText(text: 'top_recommended'.tr, size: ThemeAppSize.kFontSize18)],
    );
  }
}

class _BodyRecommended extends StatelessWidget {
  const _BodyRecommended();
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
              controller.startAnimation.value ? 0 : context.width,
              0,
              0,
            ),
            child: _ItemBuild(
              item: controller.recommendedProductList[index],
              index: index,
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          SizedBox(height: ThemeAppSize.kInterval12),
    );
  }
}

class _ItemBuild extends StatefulWidget {
  final ProductModel item;
  final int index;
  const _ItemBuild({required this.item, required this.index});
  @override
  _ItemBuildState createState() => _ItemBuildState();
}

class _ItemBuildState extends State<_ItemBuild> with SingleTickerProviderStateMixin {
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

  Widget hiding(List<Widget> widgets) {
    return SizeTransition(
      axisAlignment: 1.0,
      sizeFactor: animation,
      child: Column(
        children: widgets,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => _runExpandCheck(),
          child: _ItemContainer(
            select: expand,
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ItemImg(item: widget.item, select: expand),
                    hiding([
                      SizedBox(height: ThemeAppSize.kInterval5),
                      _ItemPrice(price: widget.item.price.toString(), select: expand),
                    ]),
                  ],
                ),
                SizedBox(width: ThemeAppSize.kInterval12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _ItemName(name: widget.item.name as String),
                      hiding([
                        SizedBox(height: ThemeAppSize.kInterval5),
                        _ItemDescription(description: widget.item.description!),
                        SizedBox(height: ThemeAppSize.kInterval24),
                        _ItemButton(item: widget.item, select: expand),
                      ]),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        _ItemTopIndecator(index: widget.index, select: expand),
      ],
    );
  }
}

class _ItemContainer extends StatelessWidget {
  final RxBool select;
  final Widget child;
  const _ItemContainer({required this.select, required this.child});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedContainer(
        decoration: BoxDecoration(
          color: !select.value
              ? context.theme.cardColor
              : ThemeAppColor.kAccentCard,
          borderRadius: BorderRadius.all(
            Radius.circular(
              select.value ? ThemeAppSize.kRadius12 : ThemeAppSize.kRadius18,
            ),
          ),
        ),
        padding: EdgeInsets.all(ThemeAppSize.kInterval12),
        duration: const Duration(milliseconds: 300),
        child: child,
      ),
    );
  }
}

///////////////////////////
///// Item Components ////
//////////////////////////

class _ItemName extends StatelessWidget {
  final String name;
  const _ItemName({required this.name});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: BigText(
        text: name,
        maxLines: 2,
        color: context.theme.accentColor,
        size: ThemeAppSize.kFontSize16 * 1.4,
      ),
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
            widget: CartAddIcon(
              product: item,
              bg: context.theme.scaffoldBackgroundColor,
            ),
            select: select),
        SizedBox(width: ThemeAppSize.kInterval12),
        AnimationScaleWidget(
          durationMilliseconds: 1750,
          widget: FavoritIcon(
            product: item,
            bg: context.theme.scaffoldBackgroundColor,
          ),
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
            text: '${'total'.tr}  $price \$',
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
  final ProductModel item;
  final RxBool select;
  const _ItemImg({required this.item, required this.select});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(
        MainRoutes.getDetailed(item.id),
        arguments: item,
      ),
      child: Obx(() {
        final size = !select.value ? ThemeAppSize.kHeight75 : ThemeAppSize.kHeight100;
        return AnimatedContainer(
          width: !select.value ? size : size,
          height: !select.value ? size : size * 1.3,
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: context.theme.cardColor,
            borderRadius: ThemeAppFun.decoration(
              radius: select.value ? ThemeAppSize.kRadius12 : ThemeAppSize.kRadius18,
            ),
            image: DecorationImage(
              image: NetworkImage(item.imgs?.first.imgURL as String),
              fit: BoxFit.cover,
            ),
          ),
        );
      }),
    );
  }
}

class _ItemTopIndecator extends StatelessWidget {
  final RxBool select;
  final int index;
  const _ItemTopIndecator({required this.select, required this.index});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedPositioned(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        top: 0,
        right: select.value ? 0 : ThemeAppSize.kInterval12,
        bottom: 0,
        child: AnimatedAlign(
          alignment: select.value ? Alignment.topCenter : Alignment.center,
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
          child: Container(
            width: ThemeAppSize.kInterval12 * 3,
            height: ThemeAppSize.kInterval12 * 3,
            decoration: BoxDecoration(
              color: ThemeAppColor.kYellow,
              borderRadius: BorderRadius.all(
                Radius.circular(
                    !select.value ? ThemeAppSize.kRadius18 : ThemeAppSize.kRadius12),
              ),
            ),
            child: Center(
              child: BigText(
                maxLines: 2,
                text: '${index + 1}',
                color: context.theme.cardColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
