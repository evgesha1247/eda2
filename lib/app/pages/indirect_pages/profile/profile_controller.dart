import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  User? user;
  @override
  void onInit() {
    try {
      user = FirebaseAuth.instance.currentUser as User;
    } catch (e) {
      user = null;
    }

    super.onInit();
  }
}
