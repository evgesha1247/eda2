
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/repository/auth_repo.dart';

class AuthController extends GetxController {
  //// tog page
  final RxBool _isLogScreen = true.obs;
  get isLogScreen => _isLogScreen.value;
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

  late final List settingControler = [cName, cPhone, cAddress, cPhotoURL];
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

  Future<void> getDataUser() async {
    if (authRepo.firebaseUser.value != null) {
      DocumentReference user = FirebaseFirestore.instance
          .collection('users')
          .doc(authRepo.firebaseUser.value?.uid);
      userData.value = await user
          .get()
          .then((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>);


    }
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
    });
    getDataUser();
  }

  Future<void> logoutUser() async {
    await authRepo.logout();
  }

////


Future<DocumentReference?> onUserInit() async {
    if (authRepo.firebaseUser.value != null) {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(authRepo.firebaseUser.value?.uid);
    }
    return null;
  }

  Future<void> saveUpData() async {
    final user = await onUserInit();
    if (user != null) {
      _setName(user);
      _setPhone(user);
      setImgUrl();
      _setAdress(user);

      clearControlls();
      getDataUser();
    } else {
      Get.snackbar('User', 'is not initialized', snackPosition: SnackPosition.TOP);
    }


  }

  clearControlls() {
    cName.text = '';
    cPhone.text = '';
    cPhotoURL.text = '';
    cEmail.text = '';
  }

  Future<void> _setName(DocumentReference user) async {
    if (cName.text != '') {
      await user.update({'name': cName.text});
      Get.snackbar('Name', 'up data', snackPosition: SnackPosition.TOP);
    }
  }

  Future<void> _setAdress(DocumentReference user) async {
    if (cAddress.text != '') {

      await user.update({'adress': cAddress.text});
      Get.snackbar('adress', 'up data', snackPosition: SnackPosition.TOP);
    }
  }


  Future<void> _setPhone(DocumentReference user) async {
    if (cPhone.text != '') {
      await user.update({'phone': cPhone.text});
      Get.snackbar('phone', 'up data', snackPosition: SnackPosition.TOP);

    }
  }

  Future<void> setImgUrl() async {
    final user = await onUserInit();
    if (cPhotoURL.text != '' && user != null) {
      await user.update({'imgURL': cPhotoURL.text});
      Get.snackbar('Img URL', 'UpData !', snackPosition: SnackPosition.TOP);
      Get.back();
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


}
