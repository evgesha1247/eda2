import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/theme/theme_app.dart';
import 'package:text/app/widgets/text/my_text.dart';

import '../../widgets/icon/menu_icon.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(ThemeAppSize.kInterval12),
          child: Column(
            children: [
              const _HeaderCart(),
              SizedBox(height: ThemeAppSize.kInterval12),
              const _CartBody(),
              SizedBox(height: ThemeAppSize.kInterval12),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderCart extends StatelessWidget {
  const _HeaderCart();
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: GestureDetector(
            onTap: () => Get.back(),
            child: CustomButtonIcon(
              sizePading: ThemeAppSize.kInterval12,
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: ThemeAppColor.kBGColor,
              ),
              bg: ThemeAppColor.kFrontColor,
            ),
          ),
        ),
        const BigText(text: 'Cart', color: ThemeAppColor.kFrontColor),
      ],
    );
  }
}

class _CartBody extends StatelessWidget {
  const _CartBody();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return const Text('cart');
        },
      ),
    );
  }
}
