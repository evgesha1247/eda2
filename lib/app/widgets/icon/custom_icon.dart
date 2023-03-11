import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/widgets/icon/wrapper_icon.dart';
import '../../controllers/cart_controller.dart';
import '../../pages/primary_pages/guiding/controller/guiding_controller.dart';
import '../../routes/main_routes.dart';
import '../../theme/theme_app.dart';
import '../text/my_text.dart';



class ButtonIconBack extends StatelessWidget {
  const ButtonIconBack({super.key});
  @override
  Widget build(BuildContext context) {
    return WrapperIcon(
      colorBorder: context.theme.accentColor,
      statusBorder: true,
      child: GestureDetector(
        onTap: () => Get.back(),
        child: Icon(Icons.arrow_back_ios_new
        ),
      ),
    );
  }
}

class ButtonIconUser extends StatelessWidget {
  const ButtonIconUser({super.key});
  @override
  Widget build(BuildContext context) {
    return WrapperIcon(
      colorBorder: context.theme.hintColor,
      statusBorder: true,
      child: GestureDetector(
          onTap: () => Get.find<GuidingController>().setCurrentIndexTab(3),
          child: Icon(Icons.person_outline, color: context.theme.hintColor)),
    );
  }
}

class ButtonIconCart extends StatelessWidget {
  const ButtonIconCart({super.key});
  @override
  Widget build(BuildContext context) {
    return WrapperIcon(
      colorBorder: context.theme.hintColor,
      statusBorder: true,
      child: GestureDetector(
        onTap: () => Get.toNamed(MainRoutes.getCart),
        child: GetBuilder<CartController>(
          builder: (_) {
            return _.totalItems >= 1
                ? Row(children: [
                    Icon(
                      Icons.shopping_bag_rounded,
                      color: context.theme.hintColor,
                    ),
                    SizedBox(width: ThemeAppSize.kInterval5),
                    SmallText(text: '${_.totalItems}')
                  ])
                : Icon(
                    Icons.shopping_bag_outlined,
                    color: context.theme.hintColor,
                  );
          },
        ),
      ),
    );
  }
}
