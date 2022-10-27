import 'package:flutter/material.dart';

import '../../../repository/auth_repo.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () => AuthRepo.instance.logout(),
            child: const Text('logout')),
      ),
    );
  }
}
