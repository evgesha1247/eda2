import 'package:firebase_auth/firebase_auth.dart';

class UserApp {
  late final String id;
  UserApp.fromFirebase(User user) {
    id = user.uid;
  }
}
