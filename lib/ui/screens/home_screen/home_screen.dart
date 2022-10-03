import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text/ui/screens_factory.dart/widget_factory.dart';
import 'package:text/ui/widgets/big_text.dart';
import 'package:text/ui/widgets/small_text.dart';
import '../../../object/dish_object.dart';
import '../../theme/theme_app.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(context) {
    final mediaQuery = MediaQuery.of(context).size.width;
    final factor = ScreensFactory();
    return Scaffold(
      body: CustomScrollView(
        slivers: mediaQuery >= 370
            ? [
                SliverAppBar(
                  leading: const SizedBox.shrink(),
                  collapsedHeight: 80,
                  floating: true,
                  pinned: false,
                  snap: true,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    collapseMode: CollapseMode.pin,
                    title: factor.makeHeder(),
                  ),
                  backgroundColor: ThemeApp.kBGColor,
                ),
                const _BodyWidget(),
              ]
            : [const _BodyWidget()],
      ),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: ThemeApp.kInterval),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [_PromoWidget()],
        ),
      ),
    );
  }
}

class _PromoWidget extends StatefulWidget {
  const _PromoWidget({Key? key}) : super(key: key);
  @override
  State<_PromoWidget> createState() => _PromoWidgetState();
}

class _PromoWidgetState extends State<_PromoWidget> {
  PageController pageController = PageController(viewportFraction: .85);
  var _currPageValue = 0.0;
  double _scaleFactore = 0.8;
  double _height = 220;
  @override
  void initState() {
    super.initState();
    pageController.addListener(
      () {
        setState(() {
          _currPageValue = pageController.page!;
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.read<DishModel>().itemsHotDish;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: model.isNotEmpty
          ? [
              BigText(text: 'Hot Promo'),
              const SizedBox(height: ThemeApp.kInterval),
              SizedBox(
                height: 320,
                child: PageView.builder(
                  controller: pageController,
                  itemCount: model.length,
                  itemBuilder: (_, index) =>
                      _buildItemWidget(index, model[index]),
                ),
              ),
            ]
          : [],
    );
  }

  Widget _buildItemWidget(int index, Dish item) {
    final String imgUrl = item.imgUrl;
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
          Container(
            height: 220,
            margin: const EdgeInsets.symmetric(horizontal: ThemeApp.kInterval),
            decoration: BoxDecoration(
              color: ThemeApp.kFrontColor,
              borderRadius: ThemeApp.decoration(),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(imgUrl),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 140,
              margin: const EdgeInsets.only(
                  left: ThemeApp.kInterval * 2,
                  right: ThemeApp.kInterval * 2,
                  bottom: ThemeApp.kInterval),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: ThemeApp.decoration(),
              ),
              child: _PromoItemTextWidget(index: index),
            ),
          ),
        ],
      ),
    );
  }
}

class _PromoItemTextWidget extends StatelessWidget {
  const _PromoItemTextWidget({required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final dish = context.read<DishModel>().itemsHotDish[index];
    return Padding(
      padding: const EdgeInsets.all(ThemeApp.kInterval),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(text: dish.name, size: 25),
          const SizedBox(height: ThemeApp.kInterval),
          SmallText(text: dish.description),
          const SizedBox(height: ThemeApp.kInterval),
          SmallText(text: '(мб будут кнопки добавление)'),
        ],
      ),
    );
  }
}
