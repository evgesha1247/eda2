import 'package:flutter/material.dart';
import 'package:text/app/models/products_model.dart';
import 'package:text/app/widgets/text/my_text.dart';
import '../../../../utils/app_constants.dart';
import '../../../theme/theme_app.dart';
import '../../../widgets/icon/custom_icon.dart';

class HeaderDetailed extends StatelessWidget {
  const HeaderDetailed({super.key, required this.item});
  final ProductModel item;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: true,
      backgroundColor: ThemeAppColor.kFrontColor,
      surfaceTintColor: ThemeAppColor.kFrontColor,
      expandedHeight: ThemeAppSize.kDetaildHeaderImg,
      toolbarHeight: ThemeAppSize.kDetaildHeaderImgToolbar,
      excludeHeaderSemantics: true,
      titleSpacing: ThemeAppSize.kInterval24,
      title: const _HeaderIcons(),
      flexibleSpace: _HeaderImg(
        img: "${AppConstansts.BASE_URL}/uploads/${item.img}",
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: _BodyTitle(name: item.name!),
      ),
    );
  }
}

class _HeaderImg extends StatelessWidget {
  const _HeaderImg({required this.img});
  final String img;
  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      background: Image.network(
        img,
        width: double.maxFinite,
        fit: BoxFit.cover
      ),
    );
  }
}

class _HeaderIcons extends StatelessWidget {
  const _HeaderIcons();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        ButtonIconBack(
          iconColor: ThemeAppColor.kFrontColor,
          bg: ThemeAppColor.kBGColor,
        ),
        ButtonIconCart(borderColor: ThemeAppColor.kBGColor),
      ],
    );
  }
}

class _BodyTitle extends StatelessWidget {
  const _BodyTitle({required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ThemeAppColor.kBGColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(ThemeAppSize.kRadius20 * 2),
        ),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: ThemeAppSize.kInterval12 * 1.5,
          ),
          child: BigText(
            text: name,
            color: ThemeAppColor.kFrontColor,
            size: ThemeAppSize.kFontSize22,
          ),
        ),
      ),
    );
  }
}
