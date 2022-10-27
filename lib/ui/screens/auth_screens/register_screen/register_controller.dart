import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/repository/auth_repo.dart';

class RegisterController extends GetxController {
  static RegisterController get instance => Get.find();

  final cName = TextEditingController();
  final cEmail = TextEditingController();
  final cPassword = TextEditingController();

  Future<void> registerUser({required email, required pass}) async {
    AuthRepo.instance.createUser(email: email, password: pass);
  }
}
