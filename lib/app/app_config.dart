class AppConfig {
  // Network Config
  static const baseUrl = String.fromEnvironment('BASE_URL');

  // Cognito Config
  static const cognitoIdentityPoolId =
      String.fromEnvironment('COGNITO_IDENTITY_POOL_ID');
  static const cognitoPoolId = String.fromEnvironment('COGNITO_POOL_ID');
  static const cognitoClientId =
      String.fromEnvironment('COGNITO_APP_CLIENT_ID');
  static const cognitoRegion = String.fromEnvironment('COGNITO_REGION');
  static const cognitoClientDomain =
      String.fromEnvironment('COGNITO_CLIENT_DOMAIN');

  // Firebase Config
  static const firebaseName = String.fromEnvironment('FIREBASE_NAME');
  static const firebaseAndroidApiKey =
      String.fromEnvironment('FIREBASE_ANDROID_API_KEY');
  static const firebaseIosApiKey =
      String.fromEnvironment('FIREBASE_IOS_API_KEY');
  static const firebaseAndroidAppId =
      String.fromEnvironment('FIREBASE_ANDROID_APP_ID');
  static const firebaseIosAppId = String.fromEnvironment('FIREBASE_IOS_APP_ID');
  static const firebaseMessagingSenderId =
      String.fromEnvironment('FIREBASE_MESSAGING_SENDER_ID');
  static const firebaseProjectId =
      String.fromEnvironment('FIREBASE_PROJECT_ID');
  static const firebaseStorageBucket =
      String.fromEnvironment('FIREBASE_STORAGE_BUCKET');
  static const firebaseIosBundleId =
      String.fromEnvironment('FIREBASE_IOS_BUNDLE_ID');

  // LOG
  static const logEnabled = bool.fromEnvironment('LOG_ENABLED');
}
