import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/auth_controller.dart';
import '../../../widgets/text/my_button_text.dart';
import '../../../widgets/text/my_text.dart';

class BottomAuth extends StatelessWidget {
  const BottomAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _ToggLog(),
        _AuthButtonSubmit(),
      ],
    );
  }
}

class _AuthButtonSubmit extends StatelessWidget {
  const _AuthButtonSubmit();
  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.find();
    return Obx(
      () => InkWell(
        onTap: () => controller.authUser(),
          child: MyButtonString(
            text: controller.buttonText,
          )


      ),
    );
  }
}

class _ToggLog extends StatelessWidget {
  const _ToggLog();
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    return InkWell(
        onTap: () => controller.togScreenAuth(),
        child: Center(
            child: Obx(
          () => BigText(
            text: controller.isLogScreen ? 'no_accaount'.tr : 'have_an_account'.tr,
            color: context.theme.hintColor,
          ),
        )));
  }
}
