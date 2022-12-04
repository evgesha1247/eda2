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
        color: ThemeAppColor.kFrontColor,
        borderRadius: BorderRadius.all(
          Radius.circular(ThemeAppSize.kRadius20),
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
    return GetBuilder<CartController>(
      builder: (_) {
        final totalAmount = _.totalAmount.toString();
        return Column(
          //  crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _.totalAmount > 200
                ? Row(
                    children: [
                      const SmallText(text: 'discount'),
                      SizedBox(width: ThemeAppSize.kInterval12),
                      BigText(
                        text: '-${_.discount} % ',
                        color: Colors.lightGreen,
                      ),
                      SizedBox(height: ThemeAppSize.kInterval12),
                    ],
                  )
                : const SizedBox.shrink(),
            Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SmallText(text: 'total'),
                SizedBox(width: ThemeAppSize.kInterval12),
                BigText(text: totalAmount),
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
  _ButtonCart();
  final controller = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.clearCart(),
      child: Container(
        padding: EdgeInsets.all(ThemeAppSize.kInterval12),
        decoration: BoxDecoration(
          color: ThemeAppColor.kAccent,
          borderRadius: ThemeAppFun.decoration(
            radius: ThemeAppSize.kRadius12,
          ),
        ),
        child: BigText(
          text: ' Pay ',
          color: ThemeAppColor.kBGColor,
          size: ThemeAppSize.kFontSize20,
        ),
      ),
    );
  }
}
