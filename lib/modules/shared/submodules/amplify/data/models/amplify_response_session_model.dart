import '../../domain/entities/amplify_response_session_entity.dart';

class AmplifyResponseSessionModel extends AmplifyResponseSessionEntity {
  AmplifyResponseSessionModel({
    super.isSignedIn = false,
    super.token,
    super.refreshToken,
  });
}
