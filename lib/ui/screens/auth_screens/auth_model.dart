import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../navigations/main_navigation.dart';

class AuthModel extends ChangeNotifier {
  void showRegister(BuildContext context) =>
      Navigator.pushNamed(context, MainNavigationRouteName.register);
  void showLogin(BuildContext context) =>
      Navigator.pushNamed(context, MainNavigationRouteName.login);

  Future<void> createUser({name, age, adress, phone}) async {
    // final user = UserApp(
    //   name: name.text,
    //   age: int.parse(age.text),
    //   address: adress.text,
    //   telephone: phone.text,
    // );
    // final docUser = FirebaseFirestore.instance.collection('users').doc();
    // user.id = docUser.id;
    // final json = user.toJson();
    // await docUser.set(json);
  }
}
