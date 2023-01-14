import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/repository/auth_repo.dart';
import '../models/user_model.dart';

class AuthController extends GetxController {
  final cName = TextEditingController();
  final cEmail = TextEditingController();
  final cPassword = TextEditingController();


  //  Settting Profile
  final cSettingName = TextEditingController();
  final cSettingPhone = TextEditingController();
  final cSettingPhotoURL = TextEditingController();
  //////////////////////


  late UserModel? userData;
  Rx<User?>? firebaseUser;
  late final AuthRepo authRepo;
  late final DocumentReference userStory;
@override
  onInit() {
authRepo = Get.find<AuthRepo>();
    try {
      userStory = authRepo.storyUser.doc(authRepo.firebaseUser.value!.uid);
      firebaseUser = authRepo.firebaseUser;
      initUser();
    } catch (e) {
      debugPrint('user is null $e');
    }
    super.onInit();
}

void initUser() async {
    final ref = userStory.withConverter(
      fromFirestore: UserModel.fromFirestore,
      toFirestore: (UserModel user, _) => user.toFirestore(),
    );
    final docSnap = await ref.get();
    userData = docSnap.data() as UserModel; // Convert to City object
    if (userData != null) {
    } else {
      print("No such document.");
    }
    cSettingName.text = userData?.name ?? '';
    cSettingPhone.text = userData?.phone ?? '';
    cSettingPhotoURL.text = userData?.imgURL ?? '';

}
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
        ? await authRepo.loginUser(email: email, password: pass)
        : await authRepo.createUser(email: email, password: pass);
  }

  Future<void> logoutUser() async {
    // final authRepo = Get.find<AuthRepo>();
    // await authRepo.logout();
  }

////



Future<void> saveUpData() async {
    if (cSettingName.text != '') {
      await _setUserName();
    }
    if (cSettingPhone.text != '') {
      await _setUserPhotoURL();
    }
    if (cSettingPhotoURL.text != '') {
      await _setUserPhone();
    }
  }

  Future<void> _setUserName() async {
    authRepo.storyUser
        .doc(authRepo.firebaseUser.value!.uid)
        .set({"name": cSettingPhone.text});
    await authRepo.firebaseUser.value?.updateDisplayName(cSettingName.text);
}


Future<void> _setUserPhone() async {
    authRepo.storyUser
        .doc(authRepo.firebaseUser.value!.uid)
        .set({"Phone": cSettingPhone.text});
    //{"Phone": cSettingPhone.text}
    //   await authRepo.firebaseUser.value?.updatePhoneNumber(cSettingPhone.text);
  }

  Future<void> _setUserPhotoURL() async {
    authRepo.storyUser
        .doc(authRepo.firebaseUser.value!.uid)
        .set({"PhotoURL": cSettingPhone.text});
    await authRepo.firebaseUser.value?.updatePhotoURL(cSettingPhotoURL.text);
  }




}
