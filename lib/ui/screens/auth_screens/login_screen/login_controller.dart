import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../repository/auth_repo.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final cEmail = TextEditingController();
  final cPassword = TextEditingController();

  Future<void> loginUser({required email, required pass}) async {
    AuthRepo.instance.loginUser(email: email, password: pass);
  }
}
