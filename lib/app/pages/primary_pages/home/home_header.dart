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

class HeaderHome extends StatelessWidget {
  const HeaderHome({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductController>();
    controller.animationInit();
    switch (controller.popularStatusLoad) {
      case ProductStatusLoad.loading:
        return SizedBox(
          height: ThemeAppSize.kScreensHeight,
          child: const CircularWidget(),
        );
      case ProductStatusLoad.error:
        return const _ErrorHeaderHome();
      case ProductStatusLoad.received:
        return const _ReceivedHeaderHome();
    }
  }
}

class _ReceivedHeaderHome extends StatelessWidget {
  const _ReceivedHeaderHome();
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductController>();
    return Obx(
      () => AnimatedContainer(
        padding: EdgeInsets.all(ThemeAppSize.kInterval12),
        curve: Curves.fastOutSlowIn,
        duration: const Duration(milliseconds: 800),
        transform: Matrix4.translationValues(
          0,
          controller.startAnimation.value ? 0 : -context.height,
          0,
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _TitleHeaderHome(),
            ButtonIconCart(),
          ],
        ),
      ),
    );
  }
}

class _TitleHeaderHome extends StatelessWidget {
  const _TitleHeaderHome();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const _UserIconHeaderHome(),
        SizedBox(width: ThemeAppSize.kInterval12),
        const _UserTitleHeaderHome(),
      ],
    );
  }
}

class _UserIconHeaderHome extends StatelessWidget {
  const _UserIconHeaderHome();
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GuidingController>();
    return GestureDetector(
      onTap: () => controller.setCurrentIndexTab(3),
      child: WrapperIcon(
        colorBorder: context.theme.hintColor,
        icon:
          Icons.person_outline,

      ),
    );
  }
}

class _UserTitleHeaderHome extends StatelessWidget {
  const _UserTitleHeaderHome();
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    return Obx(() => Row(
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
        ));
  }
}

/// error ///
class _ErrorHeaderHome extends StatelessWidget {
  const _ErrorHeaderHome();
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
