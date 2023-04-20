import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/widgets/load/circular.dart';

import '../../../controllers/auth_controller.dart';
import '../../../theme/theme_app.dart';
import '../../../widgets/icon/wrap_icon.dart';
import '../../../widgets/show_dialog/custom_show_dialog.dart';
import '../../../widgets/text/my_button_text.dart';
import '../../../widgets/text/my_text.dart';
import '../../../widgets/text_field/my_text_field.dart';
class BodyAuth extends StatelessWidget {
  const BodyAuth({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _AuthRegisterSection(),
        SizedBox(height: ThemeAppSize.kInterval12),
        const _AuthLoginSection(),
      ],
    );
  }
}

class _AuthLoginSection extends StatelessWidget {
  const _AuthLoginSection();
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    return Column(
      children: [
        MyTextField(
          textController: controller.cEmail,
          text: 'Ivan@gmail.com',
          icon: Icons.mail,
        ),
        SizedBox(height: ThemeAppSize.kInterval12),
        MyTextField(
          textController: controller.cPassword,
          text: 'Password',
          icon: Icons.key,
        ),
      ],
    );
  }
}

class _AuthRegisterSection extends StatelessWidget {
  const _AuthRegisterSection();
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return Obx(
      () => controller.isLogScreen
          ? const SizedBox.shrink()
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _ImgUser(),
                SizedBox(width: ThemeAppSize.kInterval12),
                Expanded(
                  child: Column(
                    children: [
                      MyTextField(
                        textController: controller.cName,
                        text: 'Ivan',
                        icon: Icons.person,
                      ),
                      SizedBox(height: ThemeAppSize.kInterval12),
                      MyTextField(
                        textController: controller.cPhone,
                        text: 'Phone',
                        icon: Icons.phone,
                      ),
                      SizedBox(height: ThemeAppSize.kInterval12),
                      MyTextField(
                        textController: controller.cAddress,
                        text: 'Address',
                        icon: Icons.add_location_alt,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class _ImgUser extends StatelessWidget {
  const _ImgUser();
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    Widget imgBloc() {
      return Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          Obx(() => SizedBox(
                width: ThemeAppSize.kHeight75 * 2,
                height: 150,
                child: controller.imgUrlRegister.value == ''
                    ? WrapperIcon(
                        colorBorder: context.theme.hintColor,
                        icon: Icons.person,
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(ThemeAppSize.kRadius12),
                        ),
                        child: Image.network(
                          width: ThemeAppSize.kHeight75 * 2,
                          height: 150,
                          fit: BoxFit.cover,
                          controller.cPhotoURL.text,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              fit: BoxFit.cover,
                              'assets/imgs/error_avatar.png',
                            );
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            return loadingProgress == null
                                ? child
                                : CircularWidget(
                                    value: loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress.cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  );
                          },
                        ),
                      ),
              )),
          WrapperIcon(
            bg: context.theme.scaffoldBackgroundColor,
            colorBorder: context.theme.hintColor,
            icon: Icons.add,
          ),
        ],
      );
    }

    return InkWell(
      onTap: () => customShowDialog(
        widget: const _UpDataImg(),
        radius: ThemeAppSize.kRadius18,
      ),
      child: imgBloc(),
    );
  }
}

class _UpDataImg extends StatelessWidget {
  const _UpDataImg();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return Padding(
      padding: EdgeInsets.all(ThemeAppSize.kInterval24),
      child: Wrap(
        runSpacing: ThemeAppSize.kInterval24,
        children: [
          Stack(
            children: [
              Center(
                child: BigText(
                  text: 'Введите ссылку'.tr,
                  size: ThemeAppSize.kFontSize20 * 1.3,
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  child: Icon(Icons.close, color: context.theme.hintColor),
                  onTap: () => Get.back(),
                ),
              ),
            ],
          ),
          SizedBox(height: ThemeAppSize.kInterval24),
          MyTextField(
            textController: controller.cPhotoURL,
            text: 'img URL',
            icon: Icons.image,
          ),
          InkWell(
            onTap: () => controller.setUrlRegister(),
              child: const MyButtonString(
                text: 'save',
              )
          ),
          SizedBox(height: ThemeAppSize.kInterval24),
        ],
      ),
    );
  }
}
