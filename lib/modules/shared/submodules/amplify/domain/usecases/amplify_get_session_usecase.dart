import 'package:result_dart/result_dart.dart';

import '../../../../domain/bases/shared_base_usecase.dart';
import '../../../rest/domain/failures/rest_failure.dart';
import '../entities/amplify_response_session_entity.dart';
import '../repositories/amplify_repository.dart';

abstract class AmplifyGetSessionUsecase
    implements SharedBaseUsecaseOutput<AmplifyResponseSessionEntity> {}

class AmplifyGetSessionUsecaseImp implements AmplifyGetSessionUsecase {
  final AmplifyRepository _amplifyRepository;

  AmplifyGetSessionUsecaseImp({
    required AmplifyRepository amplifyRepository,
  }) : _amplifyRepository = amplifyRepository;

  @override
  AsyncResult<AmplifyResponseSessionEntity, RestFailure> call() async =>
      await _amplifyRepository.getSession();
}
