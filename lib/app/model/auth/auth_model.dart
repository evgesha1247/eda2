import 'package:flutter/material.dart';

import '../../repository/auth_repo.dart';

class AuthModel extends ChangeNotifier {
  final cName = TextEditingController();
  final cEmail = TextEditingController();
  final cPassword = TextEditingController();

  var isLogScreen = true;
  togScreenAuth() {
    isLogScreen = !isLogScreen;
    notifyListeners();
  }

  Future authUser({required email, required pass}) async {
    isLogScreen
        ? AuthRepo.instance.loginUser(email: email, password: pass)
        : AuthRepo.instance.createUser(email: email, password: pass);
    notifyListeners();
  }
}
