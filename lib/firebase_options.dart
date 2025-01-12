// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyAnThBvrrfsbgyr1_40BoxdmiEO2sLxtsA',
    appId: '1:1074893109455:web:e284ee906caefff7615fba',
    messagingSenderId: '1074893109455',
    projectId: 'gestor-vehiculos',
    authDomain: 'gestor-vehiculos.firebaseapp.com',
    storageBucket: 'gestor-vehiculos.appspot.com',
    measurementId: 'G-NL17ZE8BE4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCFncZhSKfRsf0Lqcjxe5kl9eBSe8hd0dQ',
    appId: '1:1074893109455:android:5c8ff9c631d89211615fba',
    messagingSenderId: '1074893109455',
    projectId: 'gestor-vehiculos',
    storageBucket: 'gestor-vehiculos.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAY4-majuc8vqLVVrtXFVvuhy25K9D7ZQQ',
    appId: '1:1074893109455:ios:f21d8cefab604e53615fba',
    messagingSenderId: '1074893109455',
    projectId: 'gestor-vehiculos',
    storageBucket: 'gestor-vehiculos.appspot.com',
    iosBundleId: 'com.example.gestorVehiculos',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAY4-majuc8vqLVVrtXFVvuhy25K9D7ZQQ',
    appId: '1:1074893109455:ios:f21d8cefab604e53615fba',
    messagingSenderId: '1074893109455',
    projectId: 'gestor-vehiculos',
    storageBucket: 'gestor-vehiculos.appspot.com',
    iosBundleId: 'com.example.gestorVehiculos',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAnThBvrrfsbgyr1_40BoxdmiEO2sLxtsA',
    appId: '1:1074893109455:web:953295faa0e0f57f615fba',
    messagingSenderId: '1074893109455',
    projectId: 'gestor-vehiculos',
    authDomain: 'gestor-vehiculos.firebaseapp.com',
    storageBucket: 'gestor-vehiculos.appspot.com',
    measurementId: 'G-XSKTKYZVCT',
  );
}
