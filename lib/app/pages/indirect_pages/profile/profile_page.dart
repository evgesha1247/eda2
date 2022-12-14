import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/widgets/icon/custom_icon.dart';
import '../../../data/repository/auth_repo.dart';
import '../../../theme/theme_app.dart';
import '../../../theme/theme_controller.dart';
import '../../../widgets/icon/anumated_icon_favorit.dart';

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
  final controller = Get.find<ThemeAppController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(ThemeAppSize.kInterval12),
      child: Row(
        children: [
          ButtonIconBack(
            iconColor: context.theme.cardColor,
          ),
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
    );
  }
}
