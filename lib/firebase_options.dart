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
    apiKey: 'AIzaSyARqbeAqW6v4awLkg7PGpWiz16Ys6kBZ7c',
    appId: '1:417857058565:web:20ef8165e2d46e2fcee96c',
    messagingSenderId: '417857058565',
    projectId: 'photo-feed-50829',
    authDomain: 'photo-feed-50829.firebaseapp.com',
    storageBucket: 'photo-feed-50829.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD7mC2MTKB00jfyCsaAZUraykoajEJKQTA',
    appId: '1:417857058565:android:5f5d8ff823521d80cee96c',
    messagingSenderId: '417857058565',
    projectId: 'photo-feed-50829',
    storageBucket: 'photo-feed-50829.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCPNtN_m_gBVRXu-7sZGCZVwe49QoCxTxg',
    appId: '1:417857058565:ios:b49f86cc381a2f10cee96c',
    messagingSenderId: '417857058565',
    projectId: 'photo-feed-50829',
    storageBucket: 'photo-feed-50829.appspot.com',
    iosClientId: '417857058565-277v83j9g0s607o9dcs5ohep6upmhg78.apps.googleusercontent.com',
    iosBundleId: 'com.example.blocStateMngmnt',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCPNtN_m_gBVRXu-7sZGCZVwe49QoCxTxg',
    appId: '1:417857058565:ios:b49f86cc381a2f10cee96c',
    messagingSenderId: '417857058565',
    projectId: 'photo-feed-50829',
    storageBucket: 'photo-feed-50829.appspot.com',
    iosClientId: '417857058565-277v83j9g0s607o9dcs5ohep6upmhg78.apps.googleusercontent.com',
    iosBundleId: 'com.example.blocStateMngmnt',
  );
}
