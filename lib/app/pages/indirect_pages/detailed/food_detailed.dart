import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/models/products_model.dart';
import 'package:text/app/theme/theme_app.dart';
import '../../../widgets/icon/custom_icon.dart';
import '../../primary_pages/guiding/controller/guiding_controller.dart';

class FoodDetailedPage extends StatelessWidget {
  late final ProductModel item;
  FoodDetailedPage({super.key}) {
    item = Get.arguments;
  }
  @override
  Widget build(BuildContext context) {
    // CustomScrollView(
    //   slivers: [
    //     HeaderDetailed(item: item),
    //     BodyDetailed(description: item.description!),
    //   ],
    // ),
    // bottomNavigationBar: BottomDetailed(item: item),
    return Scaffold(
      body: Exaple4(item: item),
    );
  }
}

class Exaple4 extends StatelessWidget {
  final ProductModel item;
  const Exaple4({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    double heightSize = 120;
    return ListView(
      shrinkWrap: true,
      children: [
        Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                _HeaderImg(img: item.imgs!.first.imgURL as String),
                _HeaderIcons(),
                Positioned(
                  bottom: -(heightSize / 2),
                  left: 50,
                  right: 50,
                  child: Container(
                    color: context.theme.canvasColor,
                    height: heightSize,
                  ),
                )
              ],
            ),
            SizedBox(height: heightSize / 2),
            Text('data'),
          ],
        ),
      ],
    );
  }
}

class _HeaderImg extends StatelessWidget {
  final String img;
  const _HeaderImg({required this.img});


  @override
  Widget build(BuildContext context) {

    Widget imgBuild(tag) {
      return Hero(
        tag: tag,
        child: Image(
          image: NetworkImage(img),
          width: double.infinity,
          height: context.height / 2.5,
          fit: BoxFit.cover,
        ),
      );
    }

    var current = Get.find<GuidingController>().currentIndexTab;
    switch (current) {
      case 0:
        return imgBuild('page0$img');
      case 1:
        return imgBuild('page1$img');
      case 2:
        return imgBuild('page2$img');
      default:
        return imgBuild('');
    }

  }
}

class _HeaderIcons extends StatelessWidget {
  const _HeaderIcons();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(ThemeAppSize.kInterval12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ButtonIconBack(
            iconColor: context.theme.hintColor,
            bg: context.theme.scaffoldBackgroundColor,
          ),
          ButtonIconCart(
            iconColor: context.theme.hintColor,
            bg: context.theme.scaffoldBackgroundColor,
          ),
        ],
      ),
    );
  }
}
