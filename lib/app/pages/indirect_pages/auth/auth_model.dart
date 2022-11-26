import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/repository/auth_repo.dart';

class AuthModel extends GetxController {
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
    isLogScreen
        ? AuthRepo.instance.loginUser(email: email, password: pass)
        : AuthRepo.instance.createUser(email: email, password: pass);
  }
}
