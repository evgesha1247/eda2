import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/controllers/auth_controller.dart';
import 'package:text/app/controllers/product_controller.dart';
import 'package:text/app/pages/primary_pages/guiding/controller/guiding_controller.dart';
import '../../../theme/theme_app.dart';
import '../../../widgets/icon/custom_icon.dart';
import '../../../widgets/icon/wrap_icon.dart';
import '../../../widgets/load/circular.dart';
import '../../../widgets/text/my_text.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductController>();
    switch (controller.popularStatusLoad) {
      case ProductStatusLoad.loading:
        return SizedBox(
          height: ThemeAppSize.kScreensHeight,
          child: const CircularWidget(),
        );
      case ProductStatusLoad.error:
        return const SizedBox();
      case ProductStatusLoad.received:
        return Obx(
          () {
            controller.animationInit();
            return AnimatedContainer(
              padding: EdgeInsets.all(ThemeAppSize.kInterval12),
              curve: Curves.easeInOut,
              duration: const Duration(milliseconds: 800),
              transform: Matrix4.translationValues(
                0,
                controller.startAnimation.value ? 0 : -context.height,
                0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  _UserTitile(),
                  ButtonIconCart(),
                ],
              ),
            );
          },
        );
    }
  }
}

class _UserTitile extends StatelessWidget {
  const _UserTitile();
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    Widget userIcon() {
      return GestureDetector(
        onTap: () => Get.find<GuidingController>().setCurrentIndexTab(3),
        child: WrapperIcon(
          colorBorder: context.theme.hintColor,
          child: Icon(
            Icons.person_outline,
            color: context.theme.hintColor,
          ),
        ),
      );
    }

    Widget userGreetings() {
      return Obx(
        () => Row(
          children: [
            FittedBox(child: BigText(text: 'welcom'.tr)),
            if (controller.userData['name'] != null) ...[
              SizedBox(width: ThemeAppSize.kInterval5),
              Row(
                children: [
                  Icon(Icons.grid_3x3, color: context.theme.hintColor),
                  BigText(text: controller.userData['name'] ?? ''),
                ],
              ),
            ],
          ],
        ),
      );
    }

    return Row(
      children: [
        userIcon(),
        SizedBox(width: ThemeAppSize.kInterval12),
        userGreetings(),
      ],
    );
  }
}
