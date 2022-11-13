import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../repository/auth_repo.dart';

class ProfileScreen extends StatelessWidget {
  User? user;
  ProfileScreen({super.key}) {
    try {
      user = FirebaseAuth.instance.currentUser as User;
    } catch (e) {
      print('user is null !!!');
      user = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: user != null ? _ProfileBody(user: user!) : const _ErrorWidget(),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget();
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('// попробуйти зайти с другова устройсва'),
    );
  }
}

class _ProfileBody extends StatelessWidget {
  _ProfileBody({required this.user});
  User user;
    final auth = AuthRepo.instance;
  @override
  Widget build(BuildContext context) {
    // user.updatePhotoURL(
    //     "https://xakep.ru/wp-content/uploads/2020/09/320274/pivoting-h-850x491.jpg");
    return Center(
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
    );
  }
}
