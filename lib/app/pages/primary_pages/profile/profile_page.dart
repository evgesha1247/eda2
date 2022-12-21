import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/pages/primary_pages/profile/profile_body.dart';
import 'package:text/app/pages/primary_pages/profile/profile_header.dart';
import 'package:text/app/theme/theme_app.dart';
import 'package:text/app/widgets/text/my_text.dart';

import '../../../controllers/auth_controller.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final controller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      ProfileHeader(),
      Expanded(child: ProfileBody()),
    ]);
  }
}
