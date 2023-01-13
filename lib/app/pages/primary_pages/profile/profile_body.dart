// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:text/app/pages/primary_pages/profile/profile_page.dart';
import '../../../theme/theme_app.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(ThemeAppSize.kInterval12),
        child: Column(
          children: const [Spacer(), MyButtonString(text: 'logout')],
        ),
      ),
    );
  }
}
