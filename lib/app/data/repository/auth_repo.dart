// ignore_for_file: avoid_print, unused_import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/pages/indirect_pages/splash/splash_controller.dart';
import 'package:text/app/routes/main_routes.dart';
import 'package:text/app/theme/theme_app.dart';
import 'package:text/helper/dependencies.dart';


class AuthRepo extends GetxController {
  late final FirebaseAuth _auth;

  late final Rx<User?> firebaseUser;
  @override
  void onInit() async {
    try {
      _auth = FirebaseAuth.instance;
    firebaseUser = Rx<User?>(_auth.currentUser);

    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setScreen);

    } catch (e) {
      debugPrint('$e');
    }
    super.onInit();
  }

  _setScreen(User? user) async {
    if (user == null) {
      Get.offNamed(MainRoutes.getAuth);
    } else {
      Get.toNamed(MainRoutes.getSplash);
    }
  }

  Future<void> createUser({required email, required password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar('weak password !', 'please check the password');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('email already in use !', 'please check the email');
      }
    } catch (e) {
      Get.snackbar('Ошибка !', '$e');
    }
  }

  Future<void> loginUser({required email, required password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar('weak password !', 'please check the password');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('email already in use !', 'please check the email');
      }
    } catch (e) {
      Get.snackbar('Ошибка !', '$e');
    }
  }


  Future<void> logout() async => _auth.signOut();
}
