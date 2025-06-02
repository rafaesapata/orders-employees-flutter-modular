import '../../domain/entities/amplify_response_sign_in_entity.dart';

class AmplifyResponseSignInModel extends AmplifyResponseSignInEntity {
  AmplifyResponseSignInModel({
    super.isSignedIn = false,
    super.signInStep,
    super.errorMessage,
  });
}
