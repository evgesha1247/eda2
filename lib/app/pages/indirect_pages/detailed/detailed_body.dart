import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/products_model.dart';
import '../../../theme/theme_app.dart';
import '../../../widgets/text/expandable_text.dart';
import '../../../widgets/text/my_text.dart';

class BodyDetailed extends StatelessWidget {
  const BodyDetailed({super.key, required this.item});
  final ProductModel item;
  @override
  Widget build(BuildContext context) {
    List<String> imgsUrl = [];
    List.generate(
      item.imgs!.length,
      (index) => imgsUrl.add(item.imgs![index].imgURL as String),
    );
    return SliverToBoxAdapter(
      child: Column(
        children: [
          _Description(description: item.description as String),
          imgsUrl.length > 1
              ? _ImagesListBuilder(imgs: imgsUrl)
              : const SizedBox(),
        ],
      ),
    );
  }
}

class _Description extends StatelessWidget {
  final String description;
  const _Description({required this.description});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Padding(
        padding: EdgeInsets.all(ThemeAppSize.kInterval24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BigText(text: 'Introduce', color: context.theme.hintColor),
            SizedBox(height: ThemeAppSize.kInterval12),
            ExpandableTextWidget(text: description),
          ],
        ),
      ),
    );
  }
}

class _ImagesListBuilder extends StatelessWidget {
  final List<String> imgs;
  const _ImagesListBuilder({required this.imgs});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ThemeAppSize.kInterval24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BigText(text: 'More images'),
          SizedBox(height: ThemeAppSize.kInterval12),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: ThemeAppSize.kInterval12,
            runSpacing: ThemeAppSize.kInterval12,
            children: List.generate(
              imgs.length,
              (index) {
                return _ItemImg(
                  index: index,
                  imgURL: imgs[index],
                  last: imgs.length - 1,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemImg extends StatelessWidget {
  final int last;
  final String imgURL;
  final int index;
  const _ItemImg({
    required this.last,
    required this.imgURL,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final sizeImg = index != 3
        ? (context.width / 3) - ThemeAppSize.kInterval24 - 1
        : ThemeAppSize.kHeight100 * 1.5;
    return InkWell(
      onTap: () => sortByMass(img: imgURL, index: index),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(ThemeAppSize.kRadius12),
          ),
        ),
        child: Image(
          width: index != 3 ? sizeImg : double.maxFinite,
          height: sizeImg,
          image: NetworkImage(imgURL),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

void sortByMass({img, index}) {
  showGeneralDialog(
    context: Get.context!,
    barrierLabel: "",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (_, __, ___) {
      return Center(
        child: Container(
          decoration: BoxDecoration(
            color: Get.context?.theme.cardColor,
            borderRadius: BorderRadius.circular(ThemeAppSize.kRadius12),
          ),
          clipBehavior: Clip.hardEdge,
          child: Image(
            height: Get.context!.width / 2,
            width: Get.context!.width / 2,
            image: NetworkImage(img),
            fit: BoxFit.cover,
          ),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      Tween<Offset> tween;
      anim.status == AnimationStatus.reverse
          ? tween = Tween(begin: const Offset(0, 1), end: Offset.zero)
          : tween = Tween(begin: const Offset(0, -1), end: Offset.zero);

      return SlideTransition(
        position: tween.animate(anim),
        child: FadeTransition(
          opacity: anim,
          child: child,
        ),
      );
    },
  );
}
