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
      case TargetPlatform.fuchsia:
        // TODO: Handle this case.
      case TargetPlatform.linux:
        // TODO: Handle this case.
      case TargetPlatform.windows:
        // TODO: Handle this case.
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB7y9Rpug5hbwdIxC-JSXf0ucVAK8_IhYo',
    appId: '1:350986741870:web:83c37dd2c7f5e56cecde7f',
    messagingSenderId: '350986741870',
    projectId: 'education-system-ce33c',
    authDomain: 'education-system-ce33c.firebaseapp.com',
    storageBucket: 'education-system-ce33c.firebasestorage.app',
    measurementId: 'G-QFGPXFD41X',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAo__b9kAmLpt1KIwQEiG901ZM9C767VHQ',
    appId: '1:350986741870:android:ab8a671bad8d2f5becde7f',
    messagingSenderId: '350986741870',
    projectId: 'education-system-ce33c',
    storageBucket: 'education-system-ce33c.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyADuFcN2tFCseMRoYTOq6qhLNEWrdv6zxc',
    appId: '1:350986741870:ios:90fd5b5421e5e4d9ecde7f',
    messagingSenderId: '350986741870',
    projectId: 'education-system-ce33c',
    storageBucket: 'education-system-ce33c.firebasestorage.app',
    androidClientId: '350986741870-rdlm64l13g1d5mijg2o8jllu57rvtvvd.apps.googleusercontent.com',
    iosClientId: '350986741870-gjuuar4a58globmq209c792vce25dlvh.apps.googleusercontent.com',
    iosBundleId: 'com.codefox.quizzle',
  );

}