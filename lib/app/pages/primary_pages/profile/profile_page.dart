import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/controllers/cart_controller.dart';
import 'package:text/app/widgets/icon/custom_icon.dart';
import '../../../../utils/app_constants.dart';
import '../../../data/repository/auth_repo.dart';
import '../../../theme/theme_app.dart';
import '../../../theme/theme_controller.dart';
import '../../../widgets/icon/anumated_icon_favorit.dart';
import '../../../widgets/text/my_text.dart';
import '../guiding/guiding_controller.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  //final controller = Get.find<AuthRepo>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _Example(),
      // controller.firebaseUser.value != null
      //     ? _ProfileBody(controller: controller)
      //     :
    );
  }
}

// ignore: unused_element
class _ProfileBody extends StatelessWidget {
  const _ProfileBody({required this.controller});
  final AuthRepo controller;
  @override
  Widget build(BuildContext context) {
    final User user = controller.firebaseUser.value as User;
    return Center(
      child: Column(
        children: [
          Text('id : ${user.uid}'),
          Text('name : ${user.displayName}'),
          Text('photo : ${user.photoURL}'),
          Text('email : ${user.email}'),
          ElevatedButton(
            onPressed: () => controller.logout(),
            child: const Text('logout'),
          ),
        ],
      ),
    );
  }
}

class _Example extends StatelessWidget {
  _Example();
  final themeController = Get.find<ThemeAppController>();

  @override
  Widget build(BuildContext context) {
    var history = Get.find<CartController>().getCartHistoryList();
    Map<String, int> cartItemsPerOrder = Map();

    for (int i = 0; i < history.length; i++) {
      if (cartItemsPerOrder.containsKey(history[i].time)) {
        cartItemsPerOrder.update(history[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(history[i].time!, () => 1);
      }
    }

    List<int> cartOrderTimeList() =>
        cartItemsPerOrder.entries.map((e) => e.value).toList();

    List<int> itemsPerOrder = cartOrderTimeList();
    var listCount = 0;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(ThemeAppSize.kInterval12),
          child: Row(
            children: [
              GetBuilder<ThemeAppController>(
                builder: (_) {
                  return AnimatedIconWidget(
                    currIndex: (_.isLightTheme ? 0 : 1).obs,
                    fun: () => _.tooggTheme(),
                    widget1: const Icon(Icons.wallet),
                    widget2: const Icon(Icons.qr_code),
                  );
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              for (int i = 0; i < cartItemsPerOrder.length; i++)
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BigText(text: 'data'),
                      Row(
                        children: [
                          Wrap(
                              direction: Axis.horizontal,
                              children: List.generate(
                                itemsPerOrder[i],
                                (index) {
                                  if (listCount < history.length) {
                                    listCount++;
                                  }
                                  return Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          "${AppConstansts.BASE_URL}/uploads/${history[listCount - 1].img}",
                                        ),
                                      ),
                                    ),
                                    child: Text('item '),
                                  );
                                },
                              ))
                        ],
                      )
                    ],
                  ),
                )
            ],
          ),
        )
      ],
    );
  }
}
