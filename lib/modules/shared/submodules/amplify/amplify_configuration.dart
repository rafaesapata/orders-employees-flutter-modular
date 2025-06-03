import 'data/models/amplify_setup_model.dart';

abstract class AmplifyConfiguration {
  static String get json {
    final env = AmplifySetupModel.start();
    return '''{
      "UserAgent": "aws-amplify-cli/2.0",
      "Version": "1.0",
      "auth": {
        "plugins": {
          "awsCognitoAuthPlugin": {
            "UserAgent": "aws-amplify-cli/0.1.0",
            "Version": "0.1.0",
            "CognitoUserPool": {
              "Default": {
                "PoolId":"${env.poolId}",
                "AppClientId": "${env.appClientId}",
                "Region": "${env.region}"
              }
            },
            "Auth": {
              "Default": {
                "authenticationFlowType": "USER_PASSWORD_AUTH",
                "socialProviders": [],
                "usernameAttributes": ["email"],
                "signupAttributes": ["email"],
                "passwordProtectionSettings": {
                  "passwordPolicyMinLength": 8,
                  "passwordPolicyCharacters": []
                },
                "mfaConfiguration": "OFF",
                "mfaTypes": ["SMS"],
                "verificationMechanisms": ["EMAIL"]
              }
            }
          }
        }
      }
    }''';
  }
}

