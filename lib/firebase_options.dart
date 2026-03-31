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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDfOdss8o0AZ8CFOm-4th3yZ_4CHXU2wvk',
    appId: '1:489147361211:web:5a2f8a3770107d88c9469e',
    messagingSenderId: '489147361211',
    projectId: 'tradehub-d365d',
    authDomain: 'tradehub-d365d.firebaseapp.com',
    storageBucket: 'tradehub-d365d.firebasestorage.app',
  );

  // Note: These are placeholders. 
  // To get real Android/iOS support, please add an Android/iOS app in your Firebase Console.
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDfOdss8o0AZ8CFOm-4th3yZ_4CHXU2wvk',
    appId: '1:489147361211:android:your_id', // Add Android App in Firebase Console
    messagingSenderId: '489147361211',
    projectId: 'tradehub-d365d',
    storageBucket: 'tradehub-d365d.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDfOdss8o0AZ8CFOm-4th3yZ_4CHXU2wvk',
    appId: '1:489147361211:ios:your_id', // Add iOS App in Firebase Console
    messagingSenderId: '489147361211',
    projectId: 'tradehub-d365d',
    storageBucket: 'tradehub-d365d.firebasestorage.app',
    iosBundleId: 'com.example.tradehub',
  );
}
