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
            "IdentityManager": {
              "Default": {}
            },
            "CredentialsProvider": {
              "CognitoIdentity": {
                "Default": {
                  "PoolId": "${env.identityPoolId}",
                  "Region": "${env.region}"
                }
              }
            },
            "CognitoUserPool": {
              "Default": {
                "PoolId":"${env.poolId}",
                "AppClientId": "${env.appClientId}",
                "Region": "${env.region}"
              }
            },
            "Auth": {
              "Default": {
                "OAuth": {
                  "WebDomain":"${env.clientDomain}",
                  "AppClientId": "${env.appClientId}",
                  "SignInRedirectURI": "myapp://",
                  "SignOutRedirectURI": "myapp://",
                  "Scopes": [
                    "email",
                    "openid",
                    "profile",
                    "aws.cognito.signin.user.admin"
                  ]
                },
                "authenticationFlowType": "USER_SRP_AUTH",
                "socialProviders": [
                  "FACEBOOK",
                  "GOOGLE",
                  "APPLE"
                ]
              }
            }
          }
        }
      }
    }''';
  }
}
