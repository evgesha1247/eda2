import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/repository/auth_repo.dart';

class AuthController extends GetxController {
  final cName = TextEditingController();
  final cEmail = TextEditingController();
  final cPassword = TextEditingController();

  final RxBool _isLogScreen = true.obs;
  final RxString _buttonText = ''.obs;
  get buttonText =>
      _buttonText.value = _isLogScreen.value ? 'Login' : 'Register';
  get isLogScreen => _isLogScreen.value;
  togScreenAuth() {
    _isLogScreen.value = !_isLogScreen.value;
  }

  Future authUser({required email, required pass}) async {
    final authRepo = Get.find<AuthRepo>();
    isLogScreen
        ? await authRepo.loginUser(email: email, password: pass)
        : await authRepo.createUser(email: email, password: pass);
  }


  getUser() {
    return Get.find<AuthRepo>().firebaseUser;
  }

  Future logoutUser() async {
    // final authRepo = Get.find<AuthRepo>();
    // await authRepo.logout();
    print('logoutUser');
  }



}
