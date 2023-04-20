
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/repository/auth_repo.dart';

class AuthController extends GetxController {
  //// tog page
  final RxBool _isLogScreen = true.obs;
  get isLogScreen => _isLogScreen.value;


  RxString imgUrlRegister = ''.obs;
  void setUrlRegister() {
    imgUrlRegister.value = cPhotoURL.text;
  }


  final RxString _buttonText = ''.obs;
  get buttonText =>
      _buttonText.value = _isLogScreen.value ? 'login'.tr : 'register'.tr;
  togScreenAuth() {
    _isLogScreen.value = !_isLogScreen.value;
  }

  final cName = TextEditingController();
  final cPhone = TextEditingController();
  final cAddress = TextEditingController();
  final cPhotoURL = TextEditingController();

  final cEmail = TextEditingController();
  final cPassword = TextEditingController();

  late final List settingControler = [cPhone, cAddress];
  //////////////////////
  Rx<User?>? firebaseUser;
  late final AuthRepo authRepo;

/// auth
  Future authUser() async {
    if (isLogScreen) {
      await authRepo.loginUser(email: cEmail.text, password: cPassword.text);
      await getDataUser();
    } else {
      await authRepo.createUser(email: cEmail.text, password: cPassword.text);
      await createDataUser();
    }
  }
  RxMap userData = <String, dynamic>{}.obs;

  late DocumentReference? myUser;

Future<DocumentReference?> onUserInit() async {
    if (authRepo.firebaseUser.value != null) {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(authRepo.firebaseUser.value?.uid);
    }
    return null;
  }

  Future<void> getDataUser() async {
    myUser = await onUserInit();
    try {
      userData.value = await myUser!
          .get()
        .then((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>);
    } catch (e) {
      Get.snackbar('Ошибка !', '$e');
    }
    clearControlls();
  }


  Future<void> createDataUser() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set({
        "name": cName.text,
        "phone": cPhone.text,
        "imgURL": cPhotoURL.text,
        "email": cEmail.text,
      "address": cAddress.text,
    });
    getDataUser();
  }

  Future<void> logoutUser() async {
    await authRepo.logout();
  }

////


  Future<void> saveUpData() async {
    if (myUser != null) {
      await setPhone();
      await setAdress();
      await getDataUser();
    } else {
      Get.snackbar('User', 'is not initialized', snackPosition: SnackPosition.TOP);
    }
  }

  Future<void> setAdress() async {
    if (cAddress.text != '') {
      await myUser!.update({'adress': cAddress.text});
      Get.snackbar('adress', 'up data', snackPosition: SnackPosition.TOP);
    }
  }


  Future<void> setPhone() async {
    if (cPhone.text != '') {
      await myUser!.update({'phone': cPhone.text});
      Get.snackbar('phone', 'up data', snackPosition: SnackPosition.TOP);
    }
  }

  Future<void> setName() async {
    if (cName.text != '') {
      myUser!.update({'name': cName.text});
      getDataUser();
      Get.snackbar('Name', 'up data', snackPosition: SnackPosition.TOP);
    }
  }

  Future<void> setImgUrl() async {
    if (cPhotoURL.text != '') {
      await myUser!.update({'imgURL': cPhotoURL.text});
      await getDataUser();
      Get.snackbar('Img URL', 'UpData !', snackPosition: SnackPosition.TOP);
    } else {
      Get.snackbar('URl', 'indicate link !', snackPosition: SnackPosition.TOP);
    }

  }

  @override
  onInit() {
    authRepo = Get.find<AuthRepo>();
    try {
      firebaseUser = authRepo.firebaseUser;
    } catch (e) {
      debugPrint('user is null $e');
    }
    getDataUser();

    super.onInit();
  }


  clearControlls() {
    // cName.text = '';
    // cPhone.text = '';
    // cAddress.text = '';
    // cPhotoURL.text = '';
    // cEmail.text = '';
  }

}
