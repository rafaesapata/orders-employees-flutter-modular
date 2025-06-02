import '../../domain/dtos/amplify_sign_in_dto.dart';
import '../../domain/entities/amplify_response_sign_in_entity.dart';
import '../models/amplify_response_session_model.dart';

abstract class AmplifyDatasource {
  Future<void> initializeCognito();
  Future<AmplifyResponseSignInEntity> signIn(AmplifySignInDto request);
  Future<void> signOut();
  Future<AmplifyResponseSessionModel> getSession();
  Future<bool> getIsLogged();
  Future<String> getToken();
}
