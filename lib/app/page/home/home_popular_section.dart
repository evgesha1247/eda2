import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/routes/main_routes.dart';
import 'package:text/app/widgets/load/circular_widget.dart';
import '../../../utils/app_constants.dart';
import '../../controllers/popular_product_controller.dart';
import '../../models/products_model.dart';
import '../../theme/theme_app.dart';
import '../../widgets/icon/anumated_icon_favorit.dart';
import '../../widgets/icon/menu_icon.dart';
import '../../widgets/text/my_text.dart';

class HomePopularSection extends StatelessWidget {
  const HomePopularSection({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: ThemeAppSize.kInterval24),
        child: const BigText(
          text: 'Hot Promo',
          color: ThemeAppColor.kFrontColor,
          size: 25,
        ),
      ),
      SizedBox(height: ThemeAppSize.kInterval12),
      const _ItemsProductWidget(),
    ]);
  }
}

class _ItemsProductWidget extends StatefulWidget {
  const _ItemsProductWidget({Key? key}) : super(key: key);
  @override
  State<_ItemsProductWidget> createState() => _ItemsProductWidgetState();
}

class _ItemsProductWidgetState extends State<_ItemsProductWidget> {
  var _currPageValue = 0.0;
  final double _scaleFactore = 0.8;
  final double _height = ThemeAppSize.kPageViewContainer;
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<PopularProductController>(
          builder: (popularProduct) => popularProduct.isLoaded
              ? SizedBox(
                  height: ThemeAppSize.kPageView,
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: popularProduct.popularProductList.length,
                    itemBuilder: (context, index) => _itemPopularWidget(
                      index,
                      popularProduct.popularProductList[index],
                    ),
                  ),
                )
              : const CircularWidget(),
        ),
        GetBuilder<PopularProductController>(
          builder: (popularProduct) => popularProduct.isLoaded
              ? DotsIndicator(
                  dotsCount: popularProduct.popularProductList.isEmpty
                      ? 1
                      : popularProduct.popularProductList.length,
                  position: _currPageValue,
                  decorator: DotsDecorator(
                    size: const Size.square(9.0),
                    spacing:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    activeColor: ThemeAppColor.kAccent,
                    color: ThemeAppColor.kFrontColor,
                    activeSize: const Size(25.0, 9.0),
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _itemPopularWidget(int index, ProductModel item) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactore);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactore + (_currPageValue - index + 1) * (1 - _scaleFactore);
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
    final imgUrl = "${AppConstansts.BASE_URL}/uploads/${item.img!}";
    return Transform(
      transform: matrix,
      child: GestureDetector(
        onTap: () => Get.toNamed(
          MainRoutes.getDetailedFood(item.id),
          arguments: item,
        ),
        child: Stack(
          children: [
            _ItemImgWidget(imgUrl: imgUrl),
            _ItemInfoBlok(product: item),
          ],
        ),
      ),
    );
  }
}

class _ItemImgWidget extends StatelessWidget {
  const _ItemImgWidget({Key? key, required this.imgUrl}) : super(key: key);
  final String imgUrl;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: ThemeAppSize.width),
        child: Container(
          height: ThemeAppSize.kPageViewContainer,
          margin: EdgeInsets.symmetric(horizontal: ThemeAppSize.kInterval12),
          decoration: BoxDecoration(
            color: ThemeAppColor.kFrontColor,
            borderRadius: ThemeAppFun.decoration(),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(imgUrl),
            ),
          ),
        ),
      ),
    );
  }
}

class _ItemInfoBlok extends StatelessWidget {
  const _ItemInfoBlok({Key? key, required this.product}) : super(key: key);
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.all(ThemeAppSize.kInterval12),
        height: ThemeAppSize.kPageViewTextContainer,
        margin: EdgeInsets.only(
          left: ThemeAppSize.kInterval24,
          right: ThemeAppSize.kInterval24,
          bottom: ThemeAppSize.kInterval12,
        ),
        decoration: BoxDecoration(
          color: ThemeAppColor.kFrontColor,
          borderRadius: ThemeAppFun.decoration(),
          boxShadow: const [
            BoxShadow(
              blurRadius: 3.0,
              color: ThemeAppColor.kBlack,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BigText(text: product.name!),
            SizedBox(height: ThemeAppSize.kInterval5),
            SmallText(text: product.description!),
            SizedBox(height: ThemeAppSize.kInterval12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AnimatedIconWidget(
                  currIndex: 1.obs,
                  fun: () {},
                  widget1: const CustomButtonIcon(
                    icon: Icon(
                      Icons.done,
                      color: Colors.green,
                    ),
                    statusBorder: true,
                    colorBorder: Colors.green,
                  ),
                  widget2: const Icon(
                    Icons.add,
                    color: ThemeAppColor.grey,
                  ),
                ),
                AnimatedIconWidget(
                  currIndex: 1.obs,
                  fun: () => {},
                  widget1: const CustomButtonIcon(
                    icon: Icon(
                      Icons.favorite,
                      color: ThemeAppColor.kAccent,
                    ),
                    statusBorder: true,
                    colorBorder: ThemeAppColor.kAccent,
                  ),
                  widget2: const CustomButtonIcon(
                    icon: Icon(
                      Icons.favorite_outline,
                      color: ThemeAppColor.grey,
                    ),
                  ),
                ),
                // MenuButtonIcon(icon: Icons.add, statusBorder: true),
                //MenuButtonIcon(icon: Icons.favorite, statusBorder: true),
                GestureDetector(
                  onTap: () => {},
                  child: const SmallText(text: 'see more'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
