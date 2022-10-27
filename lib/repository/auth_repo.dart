import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:text/ui/screens/auth_screens/login_screen/login_screen.dart';
import 'package:text/ui/screens/auth_screens/register_screen/register_screen.dart';
import 'package:text/ui/screens_factory.dart/widget_factory.dart';

class AuthRepo extends GetxController {
  static AuthRepo get instance => Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  final factor = ScreensFactory();
  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setScreen);
    super.onReady();
  }

  _setScreen(User? user) {
    user != null
        ? Get.offAll(() => factor.makeGuiding())
        : Get.offAll(() => const LoginScreen());
  }

  Future<void> createUser({required email, required password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      firebaseUser.value != null
          ? Get.offAll(() => factor.makeGuiding())
          : Get.offAll(() => const LoginScreen());
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
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      firebaseUser.value != null
          ? Get.offAll(() => factor.makeGuiding())
          : Get.offAll(() => const RegisterScreen());
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

  Future<void> logout() async => _auth.signOut();
}
