import 'package:result_dart/result_dart.dart';

import '../../../rest/domain/failures/rest_failure.dart';
import '../dtos/amplify_sign_in_dto.dart';
import '../entities/amplify_response_session_entity.dart';
import '../entities/amplify_response_sign_in_entity.dart';

abstract class AmplifyRepository {
  AsyncResult<Unit, RestFailure> initializeCognito();
  AsyncResult<AmplifyResponseSignInEntity, RestFailure> signInCognito(
      AmplifySignInDto request);
  AsyncResult<AmplifyResponseSessionEntity, RestFailure> getSession();
  AsyncResult<String, RestFailure> getToken();
  AsyncResult<Unit, RestFailure> signOut();
  AsyncResult<bool, RestFailure> isLogged();
}
