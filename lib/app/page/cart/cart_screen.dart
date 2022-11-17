import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/theme/theme_app.dart';
import 'package:text/app/widgets/text/my_text.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);
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
      children: const [
        Align(alignment: Alignment.centerLeft, child: _CartButtonBack()),
        BigText(text: 'Cart', color: ThemeAppColor.kFrontColor)
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

class _CartButtonBack extends StatelessWidget {
  const _CartButtonBack({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.back(),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: ThemeAppFun.decoration(),
          color: ThemeAppColor.kFrontColor,
        ),
        padding: EdgeInsets.only(
          top: ThemeAppSize.kInterval12,
          bottom: ThemeAppSize.kInterval12,
          left: ThemeAppSize.kInterval12 + 10,
          right: ThemeAppSize.kInterval12,
        ),
        child: const Icon(
          Icons.arrow_back_ios,
          color: ThemeAppColor.kBGColor,
        ),
      ),
    );
  }
}
