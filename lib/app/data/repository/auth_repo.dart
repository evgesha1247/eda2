// ignore_for_file: avoid_print, unused_import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/models/user_model.dart';
import 'package:text/app/pages/indirect_pages/splash/splash_controller.dart';
import 'package:text/app/routes/main_routes.dart';
import 'package:text/app/theme/theme_app.dart';
import 'package:text/helper/dependencies.dart';


class AuthRepo extends GetxController {
  late final FirebaseAuth _auth;
  late final FirebaseFirestore _storyUser;
  CollectionReference get storyUser => _storyUser.collection('users');
  late final Rx<User?> firebaseUser;
  @override
  void onInit() async {
    try {
      _auth = FirebaseAuth.instance;
      _storyUser = FirebaseFirestore.instance;

    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setScreen);

    } catch (e) {
      debugPrint('$e');
    }
    super.onInit();
  }

  _setScreen(User? user) async {
    user == null
        ? Get.offNamed(MainRoutes.getAuth)
        : Get.toNamed(MainRoutes.getSplash);
  }

  Future<void> createUser({required email, required password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('косячный пороль.');
      } else if (e.code == 'email-already-in-use') {
        print('косячное мыло.');
      }
    } catch (e) {
      print('косяк :$e');
    }
  }

  Future<void> loginUser({required email, required password}) async {

    try {


      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {

      if (e.code == 'weak-password') {

        ThemeAppFun.printSnackBar('weak-password', title: '');
      } else if (e.code == 'email-already-in-use') {

        ThemeAppFun.printSnackBar('email-already-in-use', title: '');
      }
    } catch (e) {
      print('object _--_');
      ThemeAppFun.printSnackBar(' -__- ', title: '');

    }
  }

  Future<void> logout() async => _auth.signOut();
}
