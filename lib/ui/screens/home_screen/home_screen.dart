import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text/ui/screens/home_screen/home_model.dart';
import 'package:text/ui/widgets/text/big_text.dart';
import 'package:text/ui/widgets/text/small_text.dart';
import '../../../object/dish_object.dart';
import '../../theme/theme_app.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(context) {

    return const CustomScrollView(
      slivers: [_BodyWidget()
            ],
    );
  }
}
class _BodyWidget extends StatelessWidget {
  const _BodyWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _PromoSuction(),
          _PopularSuction(),
        ],
      ),
    );
  }
}

class _PromoSuction extends StatelessWidget {
  const _PromoSuction({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final isNotEmpty = context.watch<HomeModel>().itemsHotDish.isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: isNotEmpty
          ? [
              Padding(
                padding: EdgeInsets.all(ThemeAppSize.kInterval12),
                child: const BigText(
                  text: 'Hot Promo',
                  color: ThemeAppColor.kFrontColor,
                ),
              ),
              SizedBox(height: ThemeAppSize.kInterval12),
              const _ItemsPromoWidget(),
            ]
          : [],
    );
  }
}
class _ItemsPromoWidget extends StatefulWidget {
  const _ItemsPromoWidget({Key? key}) : super(key: key);
  @override
  State<_ItemsPromoWidget> createState() => _ItemsPromoWidgetState();
}
class _ItemsPromoWidgetState extends State<_ItemsPromoWidget> {
  var _currPageValue = 0.0;
  final double _scaleFactore = 0.85;
  final double _height = ThemeAppSize.kPageViewContainer;

  PageController pageController = PageController(viewportFraction: .85);
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
    final itemsHot = context.watch<HomeModel>().itemsHotDish;
    return Column(
      children: [
        SizedBox(
          height: ThemeAppSize.kPageView,
          child: PageView.builder(
            controller: pageController,
            itemCount: itemsHot.length,
            itemBuilder: (_, index) => _itemWidget(index, itemsHot[index]),
          ),
        ),
        DotsIndicator(
          dotsCount: itemsHot.length,
          position: _currPageValue,
          decorator: DotsDecorator(
            size: const Size.square(9.0),
            spacing: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            activeColor: ThemeAppColor.kAccent,
            color: ThemeAppColor.kFrontColor,
            activeSize: const Size(25.0, 9.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        ),
      ],
    );
  }

  Widget _itemWidget(int index, Dish dish) {
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
    final model = context.read<HomeModel>();
    final item = context.read<HomeModel>().itemsHotDish[index];
    return Transform(
      transform: matrix,
      child: GestureDetector(
        onTap: () => model.showDetail(context, item),
        child: Stack(
          children: [
            _ItemPromoImgWidget(imgUrl: dish.imgUrl),
            _ItemPromoInfoBlok(index: index),
          ],
        ),
      ),
    );
  }
}
class _ItemPromoImgWidget extends StatelessWidget {
  const _ItemPromoImgWidget({Key? key, required this.imgUrl}) : super(key: key);
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
              image: AssetImage(imgUrl),
            ),
          ),
        ),
      ),
    );
  }
}
class _ItemPromoInfoBlok extends StatelessWidget {
  const _ItemPromoInfoBlok({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    final dish = context.watch<HomeModel>().itemsHotDish[index];
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
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
        child: Padding(
          padding: EdgeInsets.all(ThemeAppSize.kInterval12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BigText(text: dish.name),
              SizedBox(height: ThemeAppSize.kInterval5),
              SmallText(text: dish.description),
              SizedBox(height: ThemeAppSize.kInterval12),
              const SmallText(text: '(цена, добавить , фаворит)'),
            ],
          ),
        ),
      ),
    );
  }
}

/// _PopularSuction
class _PopularSuction extends StatelessWidget {
  const _PopularSuction({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ThemeAppSize.kInterval12),
      child: Column(
        children: const [
          _PopularTitleWidget(),
          _PopularListBuilderWidget(),
        ],
      ),
    );
  }
}
class _PopularTitleWidget extends StatelessWidget {
  const _PopularTitleWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: ThemeAppSize.kInterval12, top: ThemeAppSize.kInterval12),
      child: Row(
        children: [
          const BigText(
            text: 'Popular',
            color: ThemeAppColor.kFrontColor,
          ),
          SizedBox(width: ThemeAppSize.kInterval5),
          SmallText(
            text: '•',
            size: ThemeAppSize.kFontSize18,
          ),
          SizedBox(width: ThemeAppSize.kInterval5),
          SmallText(
            text: 'Food pairing',
            size: ThemeAppSize.kFontSize18,
          ),
        ],
      ),
    );
  }
}
class _PopularListBuilderWidget extends StatelessWidget {
  const _PopularListBuilderWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final items = context.watch<HomeModel>().itemsMainCourse;
    final model = context.watch<HomeModel>();
    return ListView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () => model.showDetail(context, items[index]),
          child: Container(
            margin: EdgeInsets.only(
              top: ThemeAppSize.kInterval12,
              bottom: ThemeAppSize.kInterval12,
            ),
            child: Row(
              children: [
                Container(
                  height: ThemeAppSize.kListViewImgSize,
                  width: ThemeAppSize.kListViewImgSize,
                  decoration: BoxDecoration(
                      borderRadius: ThemeAppFun.decoration(),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          items[index].imgUrl,
                        ),
                      )),
                ),
                Expanded(
                  child: Container(
                    height: ThemeAppSize.kListViewTextContainer,
                    decoration: BoxDecoration(
                      color: ThemeAppColor.kAccent2,
                      borderRadius: BorderRadius.horizontal(
                        right: Radius.circular(ThemeAppSize.kRadius20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BigText(text: items[index].name),
                          SizedBox(height: ThemeAppSize.kInterval5),
                          SmallText(text: '${items[index].price} \$'),
                          SizedBox(height: ThemeAppSize.kInterval12),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
