import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/widgets/icon/my_icon.dart';
import 'package:text/app/widgets/text/big_text.dart';
import 'package:text/app/widgets/text/small_text.dart';
import '../../data/object/dish_object.dart';
import '../../theme/theme_app.dart';
import 'home_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(context) {
    return CustomScrollView(slivers: [
      SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _HeaderWidget(),
            const _PromoSuction(),
            SizedBox(height: ThemeAppSize.kInterval24),
            const _PopularSuction(),
          ],
        ),
      )
    ]);
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget();
  @override
  Widget build(BuildContext context) {
    final user = Get.put(HomeModel()).user;
    return Padding(
      padding: EdgeInsets.all(ThemeAppSize.kInterval24),
      child: Row(
        children: [
          Row(
            children: [
              user?.photoURL != null
                  ? CircleAvatar(
                      backgroundColor: ThemeAppColor.kFrontColor,
                      radius: 24,
                      child: Image(image: NetworkImage(user?.photoURL ?? '')),
                    )
                  : const Icon(
                      Icons.person_outline,
                      color: ThemeAppColor.kFrontColor,
                    ),
              SizedBox(width: ThemeAppSize.kInterval12),
              Column(
                children: [
                  SmallText(
                    text: 'Welcome',
                    color: ThemeAppColor.kFrontColor,
                    size: ThemeAppSize.kFontSize25,
                  ),
                  user?.displayName != null
                      ? BigText(
                          text: '${user?.displayName ?? ''} ',
                          color: ThemeAppColor.kFrontColor,
                          size: ThemeAppSize.kFontSize18,
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ],
          ),
          const Spacer(),
          const Icon(Icons.notifications_outlined),
        ],
      ),
    );
  }
}

class _PromoSuction extends StatelessWidget {
  const _PromoSuction({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeModel>(
      init: HomeModel(),
      builder: (c) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: c.itemsHotDish.isNotEmpty
            ? [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ThemeAppSize.kInterval24,
                  ),
                  child: const BigText(
                    text: 'Hot Promo',
                    color: ThemeAppColor.kFrontColor,
                    size: 25,
                  ),
                ),
                SizedBox(height: ThemeAppSize.kInterval12),
                const _ItemsPromoWidget(),
              ]
            : [],
      ),
    );
  }
}

class _ItemsPromoWidget extends StatefulWidget {
  const _ItemsPromoWidget({Key? key}) : super(key: key);
  @override
  State<_ItemsPromoWidget> createState() => _ItemsPromoWidgetState();
}

class _ItemsPromoWidgetState extends State<_ItemsPromoWidget> {
  var _currPageValue = 1.0;
  final double _scaleFactore = 0.8;
  final double _height = ThemeAppSize.kPageViewContainer;
  PageController pageController = PageController(
    viewportFraction: .8,
    initialPage: 1,
  );
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
    final model = Get.find<HomeModel>();
    final itemsHot = model.itemsHotDish;
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

    final model = Get.find<HomeModel>();
    return Transform(
      transform: matrix,
      child: GestureDetector(
        onTap: () {
          model.showDetail(model.itemsHotDish[index]);
        },
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
    Dish dish = Get.find<HomeModel>().itemsHotDish[index];
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
            BigText(text: dish.name),
            SizedBox(height: ThemeAppSize.kInterval5),
            SmallText(text: dish.description),
            SizedBox(height: ThemeAppSize.kInterval12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                MyIcon(icon: Icons.add, size: 30),
                MyIcon(icon: Icons.gesture, size: 30),
                MyIcon(icon: Icons.rtt, size: 30),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PopularSuction extends StatelessWidget {
  const _PopularSuction({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ThemeAppSize.kInterval24,
      ),
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
    return Row(
      children: [
        const BigText(
          text: 'Popular',
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

class _PopularListBuilderWidget extends StatelessWidget {
  const _PopularListBuilderWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = Get.put(HomeModel());
    return SizedBox(
      height: context.height / 1.2,
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: GetBuilder<HomeModel>(
              builder: (c) {
                return ListView.separated(
                  itemCount: c.itemsMainCourse.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return _itemPopular(index, model);
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(height: ThemeAppSize.kInterval12),
                );
              },
            ),
          ),
        );
      }),
    );
  }
}

Widget _itemPopular(int index, HomeModel model) {
  return GestureDetector(
    onTap: () => model.selected[index] = !model.selected[index],
    onLongPress: () => model.showDetail(model.itemsMainCourse[index]),
    child: Obx(
      () => Stack(
        children: [
          // bg
          model.selected[index]
              ? Container(
                  constraints:
                      BoxConstraints(minHeight: ThemeAppSize.kListViewImgSize),
                  decoration: BoxDecoration(
                    color: ThemeAppColor.kFrontColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(ThemeAppSize.kRadius20),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: ThemeAppSize.kListViewImgSize +
                          ThemeAppSize.kInterval24,
                      top: ThemeAppSize.kInterval12,
                      bottom: ThemeAppSize.kInterval12,
                      right: ThemeAppSize.kInterval12,
                    ),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BigText(text: model.itemsMainCourse[index].name),
                            SmallText(
                                text: model.itemsMainCourse[index].description),
                          ],
                        ),
                        SizedBox(height: ThemeAppSize.kInterval24),
                        Row(
                          children: [
                            const MyIcon(icon: Icons.add, size: 30),
                            SizedBox(width: ThemeAppSize.kInterval24),
                            const MyIcon(
                              icon: Icons.favorite_outline,
                              size: 30,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              : Positioned(
                  bottom: ThemeAppSize.kInterval12,
                  top: ThemeAppSize.kInterval12,
                  left: 0,
                  right: 30,
                  child: Container(
                    padding: EdgeInsets.only(
                      left: ThemeAppSize.kListViewImgSize +
                          ThemeAppSize.kInterval12,
                      top: ThemeAppSize.kInterval12,
                      bottom: ThemeAppSize.kInterval12,
                      right: ThemeAppSize.kInterval12,
                    ),
                    decoration: BoxDecoration(
                      color: ThemeAppColor.kAccent2,
                      borderRadius: BorderRadius.all(
                        Radius.circular(ThemeAppSize.kRadius20),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        BigText(text: model.itemsMainCourse[index].name),
                        SmallText(
                            text: '${model.itemsMainCourse[index].price}\$'),
                      ],
                    ),
                  ),
                ),
          // img
          Positioned(
            top: model.selected[index] ? ThemeAppSize.kInterval12 : null,
            bottom: model.selected[index] ? ThemeAppSize.kInterval12 : null,
            left: model.selected[index] ? ThemeAppSize.kInterval12 : null,
            child: Container(
              width: ThemeAppSize.kListViewImgSize,
              height: ThemeAppSize.kListViewImgSize,
              decoration: BoxDecoration(
                color: ThemeAppColor.kAccent2,
                borderRadius: ThemeAppFun.decoration(),
                image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: AssetImage(model.itemsMainCourse[index].imgUrl),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
