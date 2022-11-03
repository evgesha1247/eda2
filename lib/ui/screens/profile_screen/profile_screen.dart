import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:text/object/user_object.dart';
import '../../../repository/auth_repo.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final auth = AuthRepo.instance;
    final User user = FirebaseAuth.instance.currentUser as User;
    // user.updateDisplayName("Jane Q. User");
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('id : ${user.uid}'),
            Text('name : ${user.displayName}'),
            Text('photo : ${user.photoURL}'),
            Text('email : ${user.email}'),
            ElevatedButton(
                onPressed: () => auth.logout(), child: const Text('logout')),
          ],
        ),
      ),
    );
  }
}
