import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text/ui/screens_factory.dart/widget_factory.dart';
import '../../../object/dish_object.dart';
import '../../theme/theme_app.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(context) {
    final mediaQuery = MediaQuery.of(context).size.width;
    final factor = ScreensFactory();
    return Scaffold(
        body: Column(
      children: mediaQuery < 370
          ? [const _BodyWidget()]
          : [factor.makeHeder(), const _BodyWidget()],
    ));
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final length = context.watch<DishModel>().itemsHotDish.length;
    return Padding(
      padding: const EdgeInsets.only(left: ThemeApp.kInterval),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hot Promo',
            style: ThemeApp.style(fW: FontWeight.w500, size: 20),
          ),
          SizedBox(
            height: 125,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: length,
              itemBuilder: (context, index) => _PromoItemWidget(index: index),
              separatorBuilder: (context, index) =>
                  const SizedBox(width: ThemeApp.kInterval),
            ),
          ),
        ],
      ),
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
        _ContainerPromoWidget(index: index),
        Center(child: Image.asset(imgUrl, width: 125)),
      ],
    );
  }
}

class _ContainerPromoWidget extends StatelessWidget {
  const _ContainerPromoWidget({required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: ThemeApp.kInterval),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 200,
          maxWidth: 400,
        ),
        child: Container(
          padding: const EdgeInsets.only(left: 130),
          decoration: BoxDecoration(
            color: ThemeApp.kFrontColor,
            borderRadius: ThemeApp.decoration(),
          ),
          child: _ContainerPromoTextWidget(index: index),
        ),
      ),
    );
  }
}

class _ContainerPromoTextWidget extends StatelessWidget {
  const _ContainerPromoTextWidget({required this.index});
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
            child: Text(dish.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: ThemeApp.style(size: 22)),
          ),
          Text(dish.description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: ThemeApp.style(size: 16, fW: FontWeight.w400)),
          const SizedBox(height: ThemeApp.kInterval),
          Text('\$ ${dish.price}',
              style: ThemeApp.style(size: 18, fW: FontWeight.w400)),
        ],
      ),
    );
  }
}
