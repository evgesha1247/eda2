import 'package:flutter/material.dart';
import 'package:text/app/pages/primary_pages/profile/profile_body.dart';
import 'package:text/app/pages/primary_pages/profile/profile_header.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileHeader(),
        Expanded(child: ProfileUserInfo()),
      ],
    );
  }
}
