import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../repository/auth_repo.dart';

class AuthModel extends GetxController {
  final cName = TextEditingController();
  final cEmail = TextEditingController();
  final cPassword = TextEditingController();

  var isLogScreen = true;
  togScreenAuth() {
    isLogScreen = !isLogScreen;
    update();
  }

  Future authUser({required email, required pass}) async {
    isLogScreen
        ? AuthRepo.instance.loginUser(email: email, password: pass)
        : AuthRepo.instance.createUser(email: email, password: pass);
    update();
  }
}
