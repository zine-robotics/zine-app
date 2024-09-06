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
    apiKey: 'AIzaSyBKO7_pIyHv2MMTrKaHeaWZ_EKO23j4D8Q',
    appId: '1:471463933365:web:2783da7444a7780a1b95fc',
    messagingSenderId: '471463933365',
    projectId: 'zineapp-a672b',
    authDomain: 'zineapp-a672b.firebaseapp.com',
    storageBucket: 'zineapp-a672b.appspot.com',
    measurementId: 'G-4FFH53SGQY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCN3TlLxNq4_oYJRrapy6dxtYZ4F2a0G7w',
    appId: '1:471463933365:android:7ee886a00064ecf21b95fc',
    messagingSenderId: '471463933365',
    projectId: 'zineapp-a672b',
    storageBucket: 'zineapp-a672b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCDTlbS7jpdKO75OU09S8orHifEgYvzbt0',
    appId: '1:471463933365:ios:88a64c8eabfe1cf01b95fc',
    messagingSenderId: '471463933365',
    projectId: 'zineapp-a672b',
    storageBucket: 'zineapp-a672b.appspot.com',
    iosBundleId: 'co.zine.zineapp2023',
  );

}