// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/models/products_model.dart';
import 'package:text/app/widgets/icon/anumated_icon.dart';
import '../../../controllers/product_controller.dart';
import '../../../theme/theme_app.dart';
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
    return ListView.builder(
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
    );
  }
}

class _ItemBuild extends StatefulWidget {
  final ProductModel item;
  const _ItemBuild({required this.item});
  @override
  _ItemBuildState createState() => _ItemBuildState();
}




RxBool expand = false.obs;

class _ItemBuildState extends State<_ItemBuild>
    with SingleTickerProviderStateMixin {
  late final AnimationController expandController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );
  late final Animation<double> animation = CurvedAnimation(
    parent: expandController,
    curve: Curves.fastOutSlowIn,
  );

  void _runExpandCheck() {
    expand.value = !expand.value;
    expand.value ? expandController.forward() : expandController.reverse();
  }

  Widget hiding(Widget widget) => SizeTransition(
        axisAlignment: 1.0,
        sizeFactor: animation,
        child: widget,
      );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _runExpandCheck(),
      child: Container(
        color: context.theme.cardColor,
        child: Row(
          children: [
            Column(
              children: [
                _ItemImg(img: widget.item.imgs?.first.imgURL as String),
                hiding(_ItemPrice(price: widget.item.price.toString())),
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  _ItemName(name: widget.item.name as String),
                  hiding(
                    Column(
                      children: [
                        _ItemDescription(
                            description: widget.item.description as String),
                        _ItemButton(item: widget.item),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const _ItemDivider(),
          ],
        ),
      ),
    );
  }
}

final maxHeight = ThemeAppSize.kHeight100 * 1.5;
final minHeight = ThemeAppSize.kHeight100 + ThemeAppSize.kInterval12;
final widthDivider = ThemeAppSize.kHeight75 - ThemeAppSize.kInterval12;
const durationWrapBox = Duration(milliseconds: 300);

class _ItemName extends StatelessWidget {
  final String name;
  const _ItemName({required this.name});
  @override
  Widget build(BuildContext context) {
    return BigText(text: name, color: context.theme.accentColor);
  }
}

class _ItemButton extends StatelessWidget {
  final ProductModel item;
  const _ItemButton({required this.item});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CartAddIcon(product: item),
        SizedBox(width: ThemeAppSize.kInterval12),
        FavoritIcon(product: item),
      ],
    );
  }
}

class _ItemPrice extends StatelessWidget {
  final String price;
  const _ItemPrice({required this.price});
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: ThemeAppSize.kHeight100,
      child: Center(
        child: SmallText(
          text: 'Price  $price \$',
          maxLines: 1,
          size: ThemeAppSize.kFontSize20,
          color: context.theme.accentColor,
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
      maxLines: 2,
      text: description,
      color: context.theme.accentColor,
    );
  }
}

class _ItemImg extends StatelessWidget {
  final String img;
  const _ItemImg({required this.img});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final imgSize = expand.value
          ? ThemeAppSize.kHeight100 + ThemeAppSize.kInterval12
          : ThemeAppSize.kHeight100;
      return AnimatedContainer(
        width: imgSize,
        height: imgSize,
        decoration: BoxDecoration(
          color: context.theme.cardColor,
          borderRadius: ThemeAppFun.decoration(radius: ThemeAppSize.kRadius18),
          image: DecorationImage(
            image: NetworkImage(img),
            fit: BoxFit.cover,
          ),
        ),
        duration: durationWrapBox,
      );
    });
  }
}

class _ItemDivider extends StatelessWidget {
  const _ItemDivider();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: 2,
              color: Colors.red,
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
                color: Colors.red,
              ),
            ),
            child: Center(child: BigText(text: '${1}')),
          ),
          Expanded(
            child: Container(
              width: 2,
              color: Colors.red,
            ),
          ),
        ],
      ),
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
