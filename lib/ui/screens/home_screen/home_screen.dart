import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text/ui/screens_factory.dart/widget_factory.dart';
import 'package:text/ui/widgets/big_text.dart';
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
                : [const _BodyWidget()]));
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

class _PromoWidget extends StatelessWidget {
  const _PromoWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final length = context.watch<DishModel>().itemsHotDish.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: length != 0
          ? [
              BigText(text: 'Hot Promo'),
              SizedBox(
                height: 125,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: ((_, index) => _PromoItemWidget(index: index)),
                  separatorBuilder: (_, index) =>
                      const SizedBox(width: ThemeApp.kInterval),
                  itemCount: length,
                ),
              ),
            ]
          : [],
    );
  }
}

class _PromoItemWidget extends StatelessWidget {
  const _PromoItemWidget({required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final imgUrl = context.read<DishModel>().itemsHotDish[index].imgUrl;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: ThemeApp.kInterval),
          child: LimitedBox(
            maxWidth: 360,
            child: Container(
              padding: const EdgeInsets.only(left: 130),
              decoration: BoxDecoration(
                color: ThemeApp.kFrontColor,
                borderRadius: ThemeApp.decoration(),
              ),
              child: _PromoItemTextWidget(index: index),
            ),
          ),
        ),
        Center(child: Image.asset(imgUrl, width: 125)),
      ],
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: BigText(text: dish.name),
          ),
          BigText(text: dish.description),
          const SizedBox(height: ThemeApp.kInterval),
          BigText(text: '\$ ${dish.price}'),
        ],
      ),
    );
  }
}
