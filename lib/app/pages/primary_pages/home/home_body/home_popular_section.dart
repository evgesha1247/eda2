// ignore_for_file: deprecated_member_use
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/routes/main_routes.dart';
import '../../../../controllers/product_controller.dart';
import '../../../../models/products_model.dart';
import '../../../../theme/theme_app.dart';
import '../../../../widgets/icon/anumated_icon.dart';
import '../../../../widgets/load/circular.dart';
import '../../../../widgets/text/my_text.dart';
import '../../profile/profile_page.dart';

class PopularHome extends StatelessWidget {
  const PopularHome({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      builder: (product) {
        switch (product.popularStatusLoad) {
          case ProductStatusLoad.loading:
            return SizedBox(
              height: ThemeAppSize.kHomePageView,
              child: const CircularWidget(),
            );
          case ProductStatusLoad.error:
            return const _ErrorLoadPopular();
          case ProductStatusLoad.received:
            return const ReceivedLoadPopular();
        }
      },
    );
  }
}

class ReceivedLoadPopular extends StatelessWidget {
  const ReceivedLoadPopular({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _TitlePopular(),
        SizedBox(height: ThemeAppSize.kInterval12),
        const _BodyProduct(),
      ],
    );
  }
}

class _TitlePopular extends StatelessWidget {
  const _TitlePopular();
  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: ThemeAppSize.kInterval12),
        child: BigText(
          text: 'popular_product'.tr,
          size: ThemeAppSize.kFontSize18,
        ),
      );
}

class _BodyProduct extends StatefulWidget {
  const _BodyProduct({Key? key}) : super(key: key);
  @override
  State<_BodyProduct> createState() => _BodyProductState();
}

class _BodyProductState extends State<_BodyProduct> {
  var _currPageValue = 0.0;
  final double _scaleFactore = 0.8;
  final double _height = ThemeAppSize.kHomePageView;
  final pageController = PageController(viewportFraction: .8, initialPage: 0);

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  Widget _builderItem(int index, ProductModel product) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactore);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale = _scaleFactore + (_currPageValue - index + 1) * (1 - _scaleFactore);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactore);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactore) / 2, 1);
    }
    return Transform(transform: matrix, child: _ItemContainerPopular(product: product));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: ThemeAppSize.kHomePageView,
          child: GetBuilder<ProductController>(
            builder: (_) => PageView.builder(
              controller: pageController,
              itemCount: _.popularProductList.length,
              itemBuilder: (context, index) => Obx(() {
                return AnimatedContainer(
                  curve: Curves.easeInOut,
                  duration: Duration(milliseconds: 300 + (index * 300)),
                  transform: Matrix4.translationValues(
                      _.startAnimation.value ? 0 : -context.height, 0, 0),
                  child: _builderItem(index, _.popularProductList[index]),
                );
              }),
            ),
          ),
        ),
        _ItemBotsIndicator(currPageValue: _currPageValue)
      ],
    );
  }
}

///////////////////////////
///// Item Components ////
//////////////////////////

class _ItemContainerPopular extends StatelessWidget {
  final ProductModel product;
  const _ItemContainerPopular({required this.product});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(MainRoutes.getDetailed(product.id), arguments: product),
      child: Padding(
        padding: EdgeInsets.all(ThemeAppSize.kInterval5),
        child: Stack(
          children: [
            _ItemImg(img: product.imgs?.first.imgURL as String),
            _ItemTitle(product: product),
          ],
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
    return Hero(
      tag: '0$img',
      child: Container(
        decoration: BoxDecoration(
          borderRadius: ThemeAppFun.decoration(radius: ThemeAppSize.kRadius18),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(img),
          ),
        ),
      ),
    );
  }
}

class _ItemTitle extends StatelessWidget {
  const _ItemTitle({required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.all(ThemeAppSize.kInterval12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: [Colors.transparent, Color.fromARGB(171, 33, 26, 22)],
            stops: [0.4, .9]),
        borderRadius: ThemeAppFun.decoration(
          radius: ThemeAppSize.kRadius18,
        ),
      ),
      child: Row(
        children: [
          CartAddIcon(product: product),
          SizedBox(width: ThemeAppSize.kInterval12),
          FavoritIcon(product: product),
          SizedBox(width: ThemeAppSize.kInterval12),
          Expanded(
            flex: 2,
            child: BigText(
              rightToLeft: true,
              text: product.name!,
              size: ThemeAppSize.kFontSize20,
              maxLines: 2,
              color: context.theme.accentColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemBotsIndicator extends StatelessWidget {
  final double currPageValue;
  const _ItemBotsIndicator({required this.currPageValue});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      builder: (popularProduct) => popularProduct.popularProductList.isNotEmpty
          ? DotsIndicator(
              dotsCount: popularProduct.popularProductList.length,
              position: currPageValue,
              decorator: DotsDecorator(
                size: const Size.square(9.0),
                spacing: EdgeInsets.symmetric(
                  horizontal: ThemeAppSize.kInterval12,
                  vertical: ThemeAppSize.kInterval5,
                ),
                activeColor: context.theme.primaryColor,
                color: context.theme.cardColor,
                activeSize: const Size(25.0, 9.0),
                activeShape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}

/// Error !!! ///
class _ErrorLoadPopular extends StatelessWidget {
  const _ErrorLoadPopular();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ThemeAppSize.kHomePageView,
      margin: EdgeInsets.all(ThemeAppSize.kInterval24),
      decoration: BoxDecoration(
        color: context.theme.cardColor.withOpacity(0.5),
        borderRadius: BorderRadius.all(
          Radius.circular(ThemeAppSize.kRadius12),
        ),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Image(image: AssetImage('assets/imgs/error_dish.png')),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BigText(
                  text: 'Check internet connection',
                  maxLines: 2,
                  size: ThemeAppSize.kFontSize20,
                  color: context.theme.accentColor,
                ),
                SizedBox(height: ThemeAppSize.kInterval24),
                InkWell(
                  onTap: () => Get.find<ProductController>().getDataProduct(),
                  child: const MyButtonString(text: 'connect'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
