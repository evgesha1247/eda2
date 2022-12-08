import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/pages/indirect_pages/profile/profile_controller.dart';
import 'package:text/app/widgets/icon/custom_icon.dart';
import '../../../data/repository/auth_repo.dart';
import '../../../theme/theme_app.dart';
import '../../../widgets/icon/anumated_icon_favorit.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.user != null
          ? _ProfileBody(user: controller.user as User)
          : _Example(),
    );
  }
}

class _ProfileBody extends StatelessWidget {
  const _ProfileBody({required this.user});
  final User user;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text('id : ${user.uid}'),
          Text('name : ${user.displayName}'),
          Text('photo : ${user.photoURL}'),
          Text('email : ${user.email}'),
          ElevatedButton(
            onPressed: () => AuthRepo.instance.logout(),
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
          const ButtonIconBack(),
          GetBuilder<ThemeAppController>(
            builder: (_) {
              return AnimatedIconWidget(
                currIndex: (_.isLightTheme ? 0 : 1).obs,
                fun: () => _.tooggTheme(),
                widget1: Icon(Icons.wallet),
                widget2: Icon(Icons.qr_code),
              );
            },
          ),
        ],
      ),
    );
  }
}
