import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/models/products_model.dart';
import 'package:text/app/theme/theme_app.dart';
import '../../../widgets/icon/custom_icon.dart';
import 'detailed_body.dart';
import 'detailed_bottom.dart';
import 'detailed_header.dart';

class DetailedPage extends StatelessWidget {
  late final ProductModel item;
  DetailedPage({super.key}) {
    item = Get.arguments;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              HeaderDetailed(item: item),
              BodyDetailed(item: item),
            ],
          ),
          const _HeaderIcons(),
        ],
      ),
      bottomNavigationBar: BottomDetailed(item: item),
    );
  }
}

class _HeaderIcons extends StatelessWidget {
  const _HeaderIcons();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(ThemeAppSize.kInterval12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ButtonIconBack(
            iconColor: context.theme.hintColor,
            bg: context.theme.scaffoldBackgroundColor,
          ),
          const Spacer(),
          ButtonIconCart(
            iconColor: context.theme.hintColor,
            bg: context.theme.scaffoldBackgroundColor,
          ),
        ],
      ),
    );
  }
}
