import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/repository/auth_repo.dart';

class AuthController extends GetxController {
  final cName = TextEditingController();
  final cEmail = TextEditingController();
  final cPassword = TextEditingController();


  //  Settting Profile
  final cSettingName = TextEditingController();
  final cSettingPhone = TextEditingController();
  final cSettingPhotoURL = TextEditingController();
  //////////////////////
  Rx<User?>? firebaseUser;
  late final AuthRepo authRepo;
late DocumentReference userStory;

@override
  onInit() {
    authRepo = Get.find<AuthRepo>();
    try {

      firebaseUser = authRepo.firebaseUser;
      userStory = authRepo.storyUser.doc(firebaseUser?.value!.uid);
    } catch (e) {
      debugPrint('user is null $e');
    }
    super.onInit();
}
  //// tog page
  final RxBool _isLogScreen = true.obs;
  get isLogScreen => _isLogScreen.value;
  final RxString _buttonText = ''.obs;
  get buttonText =>
      _buttonText.value = _isLogScreen.value ? 'Login' : 'Register';
  togScreenAuth() {
    _isLogScreen.value = !_isLogScreen.value;
  }


/// auth
  Future authUser({required email, required pass}) async {
    if (isLogScreen) {
      await authRepo.loginUser(email: email, password: pass);
    } else {
      await authRepo.createUser(email: email, password: pass);

    }
  }

  Future<void> logoutUser() async {
    authRepo.logout();
  }

////



Future<void> saveUpData() async {
    // authRepo.upDataUserInfo(
    //     cSettingName.text, cSettingPhone.text, cSettingPhotoURL.text);

  }

}
