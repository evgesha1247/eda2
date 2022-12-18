// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/theme/theme_app.dart';
import 'package:text/app/widgets/text/my_text.dart';
import '../../../controllers/cart_controller.dart';

class BottomCart extends StatelessWidget {
  const BottomCart({super.key});
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: ThemeAppSize.kInterval12,
      left: ThemeAppSize.kInterval12,
      right: ThemeAppSize.kInterval12,
      child: const _ContaiterCart(),
    );
  }
}

class _ContaiterCart extends StatelessWidget {
  const _ContaiterCart();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.all(
          Radius.circular(ThemeAppSize.kRadius18),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(ThemeAppSize.kInterval24),
        child: const _TotalPrice(),
      ),
    );
  }
}

class _TotalPrice extends StatelessWidget {
  const _TotalPrice();
  @override
  Widget build(BuildContext context) {
    final color = ThemeMode.system == ThemeMode.dark
        ? context.theme.scaffoldBackgroundColor
        : context.theme.accentColor;
    return GetBuilder<CartController>(
      builder: (_) {
        final totalAmount = _.totalAmount.toString();
        return Column(
          children: [
            Row(
                children: _.totalAmount > 200
                    ? [
                        SmallText(text: 'discount ', color: color),
                        SizedBox(width: ThemeAppSize.kInterval12),
                        BigText(text: '-${_.discount} % ', color: Colors.green),
                      ]
                    : []),
            Row(
              children: [
                SmallText(text: 'total', color: color),
                SizedBox(width: ThemeAppSize.kInterval12),
                BigText(text: totalAmount, color: color),
                const Spacer(),
                _ButtonCart(),
              ],
            )
          ],
        );
      },
    );
  }
}

class _ButtonCart extends StatelessWidget {
  const _ButtonCart();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (controller) {
        return GestureDetector(
          onTap: controller.getItemsList.isEmpty
              ? () {}
              : () {
                  controller.buy();
                },
          child: Container(
            padding: EdgeInsets.all(ThemeAppSize.kInterval12),
            decoration: BoxDecoration(
              color: controller.getItemsList.isNotEmpty
                  ? context.theme.primaryColor
                  : context.theme.primaryColor.withOpacity(0.5),
              borderRadius: ThemeAppFun.decoration(
                radius: ThemeAppSize.kRadius12,
              ),
            ),
            child: BigText(
              text: ' Pay ',
              color: controller.getItemsList.isNotEmpty
                  ? context.theme.accentColor
                  : context.theme.accentColor.withOpacity(0.5),
              size: ThemeAppSize.kFontSize20,
            ),
          ),
        );
      },
    );
  }
}
