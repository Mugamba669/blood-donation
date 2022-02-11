// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
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
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDXu4PUWoeu1x3OSTNSS2JcCfWn8azFIOc',
    appId: '1:348093222868:web:1b303d637a8db760eb5041',
    messagingSenderId: '348093222868',
    projectId: 'donation-39da7',
    authDomain: 'donation-39da7.firebaseapp.com',
    storageBucket: 'donation-39da7.appspot.com',
    measurementId: 'G-ZPBZVMB7GC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCoRlGI0kAyPZiv6CLOja55iv_FkoAT7MM',
    appId: '1:348093222868:android:9acf2fa5b44efc5deb5041',
    messagingSenderId: '348093222868',
    projectId: 'donation-39da7',
    storageBucket: 'donation-39da7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDR4ol0p_NJVJ3dbhnbFODIIv662fx1jdc',
    appId: '1:348093222868:ios:4ac70871803a4562eb5041',
    messagingSenderId: '348093222868',
    projectId: 'donation-39da7',
    storageBucket: 'donation-39da7.appspot.com',
    iosClientId: '348093222868-08egds4spr7aackdvtif90q9nsmsi203.apps.googleusercontent.com',
    iosBundleId: 'ios.app.blood',
  );
}
