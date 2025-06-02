import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

import '../../../../app/app_config.dart';

class FirebaseConfig {
  static FirebaseOptions get currentPlatform {
    final error = UnsupportedError(
        'DefaultFirebaseOptions are not supported for this platform.');
    if (kIsWeb) {
      throw error;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return _android;
      case TargetPlatform.iOS:
        return _ios;
      default:
        throw error;
    }
  }

  static const _android = FirebaseOptions(
    apiKey: AppConfig.firebaseAndroidApiKey,
    appId: AppConfig.firebaseAndroidAppId,
    messagingSenderId: AppConfig.firebaseMessagingSenderId,
    projectId: AppConfig.firebaseProjectId,
    storageBucket: AppConfig.firebaseStorageBucket,
  );

  static const _ios = FirebaseOptions(
    apiKey: AppConfig.firebaseIosApiKey,
    appId: AppConfig.firebaseIosAppId,
    messagingSenderId: AppConfig.firebaseMessagingSenderId,
    projectId: AppConfig.firebaseProjectId,
    storageBucket: AppConfig.firebaseStorageBucket,
    iosBundleId: AppConfig.firebaseIosBundleId,
  );
}
