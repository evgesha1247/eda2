import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/models/products_model.dart';
import 'package:text/app/pages/primary_pages/guiding/controller/guiding_controller.dart';
import 'package:text/app/widgets/text/my_text.dart';
import '../../../theme/theme_app.dart';

class HeaderDetailed extends StatelessWidget {
  const HeaderDetailed({super.key, required this.item});
  final ProductModel item;
  @override
  Widget build(BuildContext context) {
    final int indexPage = Get.find<GuidingController>().currentIndexTab;
    return SliverAppBar(
      automaticallyImplyLeading: false,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: _BodyTitle(name: '${item.name}'),
      ),
      pinned: true,
      backgroundColor: context.theme.scaffoldBackgroundColor,
      expandedHeight: ThemeAppSize.kDetaildHeaderImg,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: '$indexPage${item.imgs?.first.imgURL}',
          child: Image.network(
            '${item.imgs?.first.imgURL}',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class _BodyTitle extends StatelessWidget {
  const _BodyTitle({required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: ThemeAppSize.kInterval12 * 1.5,
      ),
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(ThemeAppSize.kRadius18 * 2),
        ),
      ),
      child: Center(
        child: BigText(
          text: name,
          color: context.theme.hintColor,
        ),
      ),
    );
  }
}
