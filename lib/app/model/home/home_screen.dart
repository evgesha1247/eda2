import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/model/cart/cart_model.dart';
import 'package:text/app/routes/main_screens.dart';
import 'package:text/app/widgets/text/big_text.dart';
import 'package:text/app/widgets/text/small_text.dart';
import '../../data/object/dish_object.dart';
import '../../theme/theme_app.dart';
import '../../widgets/icon/anumated_icon_favorit.dart';
import '../../widgets/icon/menu_icon.dart';
import '../guiding/guiding_model.dart';
import '../menu/menu_model.dart';
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
            _HeaderWidget(),
            _PromoSuction(),
            SizedBox(height: ThemeAppSize.kInterval24),
            const _PopularSuction(),
          ],
        ),
      )
    ]);
  }
}

class _HeaderWidget extends StatelessWidget {
  final controller = Get.find<HomeModel>();
  final cart = Get.find<CartModel>().cart;
  final pageModel = Get.find<GuidingScreenModel>();
  _HeaderWidget();
  @override
  Widget build(BuildContext context) {
    final user = controller.user;
    return Padding(
      padding: EdgeInsets.all(ThemeAppSize.kInterval12),
      child: Row(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => pageModel.setCurrentIndexTab(3),
                child: CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.transparent,
                  backgroundImage: user?.photoURL == null
                      ? null
                      : NetworkImage(user?.photoURL ?? ''),
                  child: user?.photoURL == null
                      ? const CustomButtonIcon(
                          icon: Icon(
                            Icons.person_outline,
                            color: ThemeAppColor.kFrontColor,
                          ),
                          colorBorder: ThemeAppColor.kFrontColor,
                          statusBorder: true,
                        )
                      : null,
                ),
              ),
              SizedBox(width: ThemeAppSize.kInterval12),
              Column(
                children: [
                  BigText(
                    text: controller.titleText,
                    color: ThemeAppColor.kFrontColor,
                  )
                ],
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Get.toNamed(MainRoutes.homeCart);
            },
            child: Obx(
              () => cart.length > 0
                  ? const Icon(Icons.notification_add_outlined)
                  : const Icon(Icons.notifications_outlined),
            ),
          ),
        ],
      ),
    );
  }
}

class _PromoSuction extends StatelessWidget {
  final HomeModel controller = Get.find();
  _PromoSuction({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: controller.itemsHotDish.isNotEmpty
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
              _ItemsPromoWidget(),
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
  var _currPageValue = 1.0;
  final double _scaleFactore = 0.8;
  final double _height = ThemeAppSize.kPageViewContainer;
  final pageController = PageController(viewportFraction: .8, initialPage: 1);
  final model = Get.find<HomeModel>();
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
    return Obx(() => Column(
          children: [
            SizedBox(
              height: ThemeAppSize.kPageView,
              child: PageView.builder(
                controller: pageController,
                itemCount: model.itemsHotDish.length,
                itemBuilder: (_, index) =>
                    _itemHotPromo(index, model.itemsHotDish[index]),
              ),
            ),
            DotsIndicator(
              dotsCount: model.itemsHotDish.length,
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
            ),
          ],
        ));
  }

  Widget _itemHotPromo(int index, Dish dish) {
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
      child: GestureDetector(
        onTap: () => model.showDetail(model.itemsHotDish[index]),
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
  _ItemPromoInfoBlok({Key? key, required this.index}) : super(key: key);
  final int index;
  final HomeModel homeControler = Get.find();
  final CartModel cartController = Get.find();
  final MenuModel menuController = Get.find();
  @override
  Widget build(BuildContext context) {
    final item = homeControler.itemsHotDish[index];
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
            BigText(text: item.name),
            SizedBox(height: ThemeAppSize.kInterval5),
            SmallText(text: item.description),
            SizedBox(height: ThemeAppSize.kInterval12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Obx(
                  () => AnimatedIconWidget(
                    currIndex: (cartController.cart[item] != null ? 0 : 1).obs,
                    fun: () => cartController.addOneAndClearProduct(item),
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
                ),
                GetBuilder<MenuModel>(
                  builder: (_) {
                    return AnimatedIconWidget(
                      currIndex:
                          (menuController.items[index].isFavorit ? 0 : 1).obs,
                      fun: () => menuController
                          .toggFovarit(menuController.items[index]),
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
                    );
                  },
                ),
                // MenuButtonIcon(icon: Icons.add, statusBorder: true),
                //MenuButtonIcon(icon: Icons.favorite, statusBorder: true),
                GestureDetector(
                  onTap: () => homeControler.showDetail(item),
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

class _PopularSuction extends StatelessWidget {
  const _PopularSuction({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ThemeAppSize.kInterval24),
      child: Column(
        children: [
          const _PopularTitleWidget(),
          SizedBox(height: ThemeAppSize.kInterval12),
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
  final HomeModel controller = Get.find();
  _PopularListBuilderWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Widget itemPopular(int index) {
      var selected = controller.selected[index].obs;
      final item = controller.itemPopular[index];
      return GestureDetector(
        onTap: () => selected.value = !selected.value,
        onLongPress: () => controller.showDetail(item),
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
                        BigText(text: item.name),
                        SizedBox(height: ThemeAppSize.kInterval12),
                        SmallText(
                          maxLines: 3,
                          text: !selected.value
                              ? '${item.price}\$'
                              : '${item.description}\$',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // img
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
                      fit: BoxFit.fitHeight,
                      image: AssetImage(item.imgUrl),
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
      height: context.height / 1.2,
      child: LayoutBuilder(

          builder: (BuildContext context, BoxConstraints viewportConstraints) {

        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Obx(() {
              return ListView.separated(
                  itemCount: controller.itemPopular.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) =>
                      itemPopular(index),
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(height: ThemeAppSize.kInterval12),
              );
            }),
          ),
        );
      }),
    );
  }
}
