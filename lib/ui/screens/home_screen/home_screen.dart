import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text/ui/screens_factory.dart/widget_factory.dart';
import 'package:text/ui/widgets/text/big_text.dart';
import 'package:text/ui/widgets/text/small_text.dart';
import '../../../object/dish_object.dart';
import '../../theme/theme_app.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(context) {
    final mediaQuery = MediaQuery.of(context).size.width;
    return CustomScrollView(
      slivers: mediaQuery >= 370
          ? [ScreensFactory().makeHeder(), const _BodyWidget()]
          : [const _BodyWidget()],
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
        children: const [_PromoWidget()],
      ),
    );
  }
}

class _PromoWidget extends StatelessWidget {
  const _PromoWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final isNotEmpty = context.watch<DishModel>().itemsHotDish.isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: isNotEmpty
          ? [
              Padding(
                padding: EdgeInsets.all(ThemeAppSize.kFontSize14),
                child: const BigText(
                  text: 'Hot Promo',
                  color: ThemeAppColor.kFrontColor,
                ),
              ),
              SizedBox(height: ThemeAppSize.kInterval12),
              const ItemsPromoWidget(),
            ]
          : [],
    );
  }
}

class ItemsPromoWidget extends StatefulWidget {
  const ItemsPromoWidget({Key? key}) : super(key: key);
  @override
  State<ItemsPromoWidget> createState() => _ItemsPromoWidgetState();
}

class _ItemsPromoWidgetState extends State<ItemsPromoWidget> {
  PageController pageController = PageController(viewportFraction: .85);
  var _currPageValue = 0.0;
  final double _scaleFactore = 0.85;
  final double _height = ThemeAppSize.kPageViewContainer;
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
    final model = context.watch<DishModel>().itemsHotDish;
    return Column(
      children: [
        SizedBox(
          height: ThemeAppSize.kPageView,
          child: PageView.builder(
            controller: pageController,
            itemCount: model.length,
            itemBuilder: (_, index) => _itemWidget(index, model[index]),
          ),
        ),
        DotsIndicator(
          dotsCount: model.length,
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
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          _ItemPromoImgWidget(imgUrl: dish.imgUrl),
          _ItemPromoInfoBlok(index: index),
        ],
      ),
    );
  }
}

class _ItemPromoImgWidget extends StatelessWidget {
  const _ItemPromoImgWidget({Key? key, required this.imgUrl}) : super(key: key);
  final String imgUrl;
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class _ItemPromoInfoBlok extends StatelessWidget {
  const _ItemPromoInfoBlok({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    final dish = context.watch<DishModel>().itemsHotDish[index];
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
              blurRadius: 5.0,
              color: ThemeAppColor.kFrontColor,
              offset: Offset(0, 4),
            ),
            BoxShadow(
              blurRadius: 4.0,
              color: ThemeAppColor.kBGColor,
              offset: Offset(4, 0),
            ),
            BoxShadow(
              blurRadius: 4.0,
              color: ThemeAppColor.kBGColor,
              offset: Offset(-5, 0),
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
              const SmallText(text: '(мб будут кнопки добавление)'),
            ],
          ),
        ),
      ),
    );
  }
}
