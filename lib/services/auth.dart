import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../ui/navigations/main_navigation.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> userRegister(context,
      {required email, required password}) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then((value) => Navigator.of(context).pushReplacementNamed(
                MainNavigationRouteName.guiding,
              ));
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

  ////
  Future<void> userLogin(context, {required email, required password}) async {
    try {
      await _auth
          .signInWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then(
            (value) => Navigator.of(context).pushReplacementNamed(
              MainNavigationRouteName.guiding,
            ),
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
}
