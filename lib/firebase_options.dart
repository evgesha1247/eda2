// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAe99ZBjEkjLyVlDScPp2Fd5X5FxUfg7h0',
    appId: '1:846993891487:web:0fdb7c483e84e4535982aa',
    messagingSenderId: '846993891487',
    projectId: 'project-10ede',
    authDomain: 'project-10ede.firebaseapp.com',
    storageBucket: 'project-10ede.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDNqdhg56VOCtVP9mB4u4M2HZmTtB5ApYE',
    appId: '1:846993891487:android:e84e56dc6e1971d75982aa',
    messagingSenderId: '846993891487',
    projectId: 'project-10ede',
    storageBucket: 'project-10ede.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC0ih9pUln1ZbQrlsFcXMd0aHsuC3rhIvg',
    appId: '1:846993891487:ios:565588fd8f0673c15982aa',
    messagingSenderId: '846993891487',
    projectId: 'project-10ede',
    storageBucket: 'project-10ede.appspot.com',
    iosClientId: '846993891487-l6asbtua3qtpoo2e6e4smhqms2t8gm6t.apps.googleusercontent.com',
    iosBundleId: 'com.example.text',
  );
}
