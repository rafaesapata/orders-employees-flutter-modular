class AppConfig {
  // Network Config
  static const baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://api.develop.verocard.udstec.io/employer-register/api/v1',
  );

  // Cognito Config - Configurações reais baseadas no projeto React
  static const cognitoIdentityPoolId = String.fromEnvironment(
    'COGNITO_IDENTITY_POOL_ID',
    defaultValue: '',
  );
  
  static const cognitoPoolId = String.fromEnvironment(
    'COGNITO_POOL_ID',
    defaultValue: 'us-east-1_X71K7DiLe',
  );
  
  static const cognitoClientId = String.fromEnvironment(
    'COGNITO_APP_CLIENT_ID',
    defaultValue: '72nk00dlm4in06ka7uf1cgd13l',
  );
  
  static const cognitoRegion = String.fromEnvironment(
    'COGNITO_REGION',
    defaultValue: 'us-east-1',
  );
  
  static const cognitoClientDomain = String.fromEnvironment(
    'COGNITO_CLIENT_DOMAIN',
    defaultValue: 'https://verocard-auth-dev.auth.us-east-1.amazoncognito.com/',
  );

  // Configurações adicionais do Cognito
  static const cognitoAuthenticationFlowType = 'USER_PASSWORD_AUTH';
  static const cognitoOAuthScopes = [
    'phone',
    'email', 
    'openid',
    'profile',
    'aws.cognito.signin.user.admin'
  ];

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
  static const logEnabled = bool.fromEnvironment('LOG_ENABLED', defaultValue: true);

  // Validação de configurações AWS
  static bool get isCognitoConfigured {
    return cognitoPoolId.isNotEmpty && 
           cognitoClientId.isNotEmpty && 
           cognitoRegion.isNotEmpty &&
           cognitoClientDomain.isNotEmpty;
  }

  // Configuração completa do Amplify
  static Map<String, dynamic> get amplifyConfig => {
    'UserAgent': 'aws-amplify-cli/2.0',
    'Version': '1.0',
    'auth': {
      'plugins': {
        'awsCognitoAuthPlugin': {
          'UserAgent': 'aws-amplify-cli/0.1.0',
          'Version': '0.1.0',
          'IdentityManager': {
            'Default': {}
          },
          'CredentialsProvider': {
            'CognitoIdentity': {
              'Default': {
                'PoolId': cognitoIdentityPoolId,
                'Region': cognitoRegion
              }
            }
          },
          'CognitoUserPool': {
            'Default': {
              'PoolId': cognitoPoolId,
              'AppClientId': cognitoClientId,
              'Region': cognitoRegion
            }
          },
          'Auth': {
            'Default': {
              'authenticationFlowType': cognitoAuthenticationFlowType,
              'socialProviders': [],
              'usernameAttributes': ['email'],
              'signupAttributes': ['email'],
              'passwordProtectionSettings': {
                'passwordPolicyMinLength': 8,
                'passwordPolicyCharacters': []
              },
              'mfaConfiguration': 'OFF',
              'mfaTypes': ['SMS'],
              'verificationMechanisms': ['EMAIL']
            }
          },
          'AppSync': {
            'Default': {
              'ApiUrl': baseUrl,
              'Region': cognitoRegion,
              'AuthMode': 'AMAZON_COGNITO_USER_POOLS',
              'ClientDatabasePrefix': 'orders_employees_app'
            }
          }
        }
      }
    }
  };
}

