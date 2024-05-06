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
        return macos;
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
    apiKey: 'AIzaSyAkhC0GeHsLJj_28JZAHTA6y9PPb-2gvr8',
    appId: '1:65851183604:web:eff5ddd69156bc19c529a1',
    messagingSenderId: '65851183604',
    projectId: 'bd-jobs-1bd7c',
    authDomain: 'bd-jobs-1bd7c.firebaseapp.com',
    databaseURL: 'https://bd-jobs-1bd7c-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'bd-jobs-1bd7c.appspot.com',
    measurementId: 'G-XT942S2XTC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCQxeYMySszMGN88iJDUh3eb1b1KydepaY',
    appId: '1:65851183604:android:187d0ba7547fd80ac529a1',
    messagingSenderId: '65851183604',
    projectId: 'bd-jobs-1bd7c',
    databaseURL: 'https://bd-jobs-1bd7c-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'bd-jobs-1bd7c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB8vVwNOWLZ3eKi8MVhUGNa7qxdJypMS5k',
    appId: '1:65851183604:ios:5fff7d20d48f732cc529a1',
    messagingSenderId: '65851183604',
    projectId: 'bd-jobs-1bd7c',
    databaseURL: 'https://bd-jobs-1bd7c-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'bd-jobs-1bd7c.appspot.com',
    iosBundleId: 'com.example.admin',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB8vVwNOWLZ3eKi8MVhUGNa7qxdJypMS5k',
    appId: '1:65851183604:ios:5fff7d20d48f732cc529a1',
    messagingSenderId: '65851183604',
    projectId: 'bd-jobs-1bd7c',
    databaseURL: 'https://bd-jobs-1bd7c-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'bd-jobs-1bd7c.appspot.com',
    iosBundleId: 'com.example.admin',
  );
}
