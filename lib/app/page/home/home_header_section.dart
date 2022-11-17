import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/main_screens.dart';
import '../../theme/theme_app.dart';
import '../../widgets/icon/menu_icon.dart';
import '../../widgets/text/my_text.dart';
import '../guiding/guiding_model.dart';

class HomeHeaderWidget extends StatelessWidget {
  final pageModel = Get.find<GuidingScreenModel>();
  HomeHeaderWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(ThemeAppSize.kInterval12),
      child: Row(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => pageModel.setCurrentIndexTab(3),
                child: const CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.transparent,
                    child: CustomButtonIcon(
                      icon: Icon(
                        Icons.person_outline,
                        color: ThemeAppColor.kFrontColor,
                      ),
                      colorBorder: ThemeAppColor.kFrontColor,
                      statusBorder: true,
                    )),
              ),
              SizedBox(width: ThemeAppSize.kInterval12),
              const BigText(
                text: 'titleText',
                color: ThemeAppColor.kFrontColor,
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Get.toNamed(MainRoutes.getCart());
            },
            child: const Icon(Icons.notifications_outlined),
          ),
        ],
      ),
    );
  }
}
