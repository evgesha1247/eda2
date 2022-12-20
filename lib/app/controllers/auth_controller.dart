import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/repository/auth_repo.dart';

class AuthController extends GetxController {
  final cName = TextEditingController();
  final cEmail = TextEditingController();
  final cPassword = TextEditingController();
  late final Rx<User?> user;
  late final AuthRepo authRepo;
  AuthController() {
    try {
      authRepo = Get.find<AuthRepo>();
      user = authRepo.firebaseUser;
    } catch (e) {
      print('user is null ');
      print(' non init authRepo ');
    }
  }
  final RxBool _isLogScreen = true.obs;
  final RxString _buttonText = ''.obs;
  get buttonText =>
      _buttonText.value = _isLogScreen.value ? 'Login' : 'Register';
  get isLogScreen => _isLogScreen.value;
  togScreenAuth() {
    _isLogScreen.value = !_isLogScreen.value;
  }

  Future authUser({required email, required pass}) async {
    isLogScreen
        ? await authRepo.loginUser(email: email, password: pass)
        : await authRepo.createUser(email: email, password: pass);
  }

  Future<void> logoutUser() async {
    // final authRepo = Get.find<AuthRepo>();
    // await authRepo.logout();
    print('logoutUser');
  }


Future<void> setUserName({required String name}) async {
    try {
      await authRepo.firebaseUser.value?.updateDisplayName(name);
    } catch (e) {
      print('error up data name ');
  }

}




}
