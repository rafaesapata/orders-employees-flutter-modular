import 'package:result_dart/result_dart.dart';

import '../../../../domain/bases/shared_base_usecase.dart';
import '../../../rest/domain/failures/rest_failure.dart';
import '../dtos/amplify_sign_in_dto.dart';
import '../entities/amplify_response_sign_in_entity.dart';
import '../repositories/amplify_repository.dart';

abstract class AmplifySignInCognitoUsecase extends SharedBaseUsecaseInputOutput<
    AmplifySignInDto, AmplifyResponseSignInEntity> {}

class AmplifySignInCognitoUsecaseImp implements AmplifySignInCognitoUsecase {
  final AmplifyRepository _amplifyRepository;

  AmplifySignInCognitoUsecaseImp({
    required AmplifyRepository amplifyRepository,
  }) : _amplifyRepository = amplifyRepository;

  @override
  AsyncResult<AmplifyResponseSignInEntity, RestFailure> call(
    AmplifySignInDto request,
  ) async =>
      await _amplifyRepository.signInCognito(request);
}
