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
      await addUserDatails(
        name: ' name user ',
        phone: 'phone user',
        imgURL:
            'https://sun2-4.userapi.com/impf/c855216/v855216408/137d0f/vXLp85bBRPw.jpg?size=1080x1080&quality=96&sign=6826f7160e783c9030c3eaeb216b59f1&type=album',
        email: email,
      );
    }
  }

  Future<void> addUserDatails({name, phone, imgURL, email}) async {
    userStory.set(
      {
        "name": name,
        "phone": phone,
        "imgURL": imgURL,
        "email": email,
      },
    );
  }
  getUserDatails() async {
    final ref = userStory.withConverter(
      fromFirestore: UserModel.fromFirestore,
      toFirestore: (UserModel user, _) => user.toFirestore(),
    );
    final docSnap = await ref.get();
    var user = docSnap.data();
    if (user != null) {
      print(user);
      print(user.email);
      print(user.phone);
      print(user.name);
    } else {
      print("No such document.");
    }
  }

  Future<void> logoutUser() async {
    try {
      final authRepo = Get.find<AuthRepo>();
      await authRepo.logout();
    } catch (e) {
      print(e);
    }
  }

////



Future<void> saveUpData() async {
    // authRepo.upDataUserInfo(
    //     cSettingName.text, cSettingPhone.text, cSettingPhotoURL.text);

  }

}
