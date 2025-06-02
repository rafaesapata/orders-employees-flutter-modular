import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

abstract class AmplifyResponseSignInEntity {
  final bool isSignedIn;
  final AuthSignInStep? signInStep;
  final String? errorMessage;

  AmplifyResponseSignInEntity({
    required this.isSignedIn,
    required this.signInStep,
    required this.errorMessage,
  });
}
