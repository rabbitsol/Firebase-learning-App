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
    apiKey: 'AIzaSyC0bqgCaTrxpV5G_VQ_jCwGCB-1sbkKQvs',
    appId: '1:166089420888:web:df6678d487ac50bdf99a2d',
    messagingSenderId: '166089420888',
    projectId: 'firebaselearning123app',
    authDomain: 'fir-learning123app.firebaseapp.com',
    storageBucket: 'firebaselearning123app.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDy8Fsxtr7or10zc3jQOJR-glad_fFPVoY',
    appId: '1:166089420888:android:30dc468f5db5e751f99a2d',
    messagingSenderId: '166089420888',
    projectId: 'firebaselearning123app',
    storageBucket: 'firebaselearning123app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyADlRTKwfeqlo9OdxRdmOPoWwWYTYaxIrk',
    appId: '1:166089420888:ios:6a57930d3455c6fcf99a2d',
    messagingSenderId: '166089420888',
    projectId: 'firebaselearning123app',
    storageBucket: 'firebaselearning123app.appspot.com',
    iosClientId: '166089420888-krj25bh7sjg5qc8llv1q1hrsge7734vf.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebaselearningapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyADlRTKwfeqlo9OdxRdmOPoWwWYTYaxIrk',
    appId: '1:166089420888:ios:6a57930d3455c6fcf99a2d',
    messagingSenderId: '166089420888',
    projectId: 'firebaselearning123app',
    storageBucket: 'firebaselearning123app.appspot.com',
    iosClientId: '166089420888-krj25bh7sjg5qc8llv1q1hrsge7734vf.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebaselearningapp',
  );
}
