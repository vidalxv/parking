import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyCpSbUs_N6J58qWrl6K_RnD6fl6v9gIKMU',
    appId: '1:244370712518:web:0b498b8090794a3c3cb4c7',
    messagingSenderId: '244370712518',
    projectId: 'estacionamento-web',
    authDomain: 'estacionamento-web.firebaseapp.com',
    storageBucket: 'estacionamento-web.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDbuBel6T2NxZCLPsVcF_7dQcbg22XmH_I',
    appId: '1:244370712518:android:6175683df2636bdd3cb4c7',
    messagingSenderId: '244370712518',
    projectId: 'estacionamento-web',
    storageBucket: 'estacionamento-web.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAxvUm-aJCQI_W6f1jsVY6sJFDa1m4cjDg',
    appId: '1:244370712518:ios:e2e8a398f9efe43a3cb4c7',
    messagingSenderId: '244370712518',
    projectId: 'estacionamento-web',
    storageBucket: 'estacionamento-web.appspot.com',
    iosBundleId: 'com.example.parking',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAxvUm-aJCQI_W6f1jsVY6sJFDa1m4cjDg',
    appId: '1:244370712518:ios:e2e8a398f9efe43a3cb4c7',
    messagingSenderId: '244370712518',
    projectId: 'estacionamento-web',
    storageBucket: 'estacionamento-web.appspot.com',
    iosBundleId: 'com.example.parking',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCpSbUs_N6J58qWrl6K_RnD6fl6v9gIKMU',
    appId: '1:244370712518:web:1b712b0c385c28a13cb4c7',
    messagingSenderId: '244370712518',
    projectId: 'estacionamento-web',
    authDomain: 'estacionamento-web.firebaseapp.com',
    storageBucket: 'estacionamento-web.appspot.com',
  );
}
