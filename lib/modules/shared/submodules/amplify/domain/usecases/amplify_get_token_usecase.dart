import 'package:result_dart/result_dart.dart';

import '../../../../domain/bases/shared_base_usecase.dart';
import '../../../rest/domain/failures/rest_failure.dart';
import '../repositories/amplify_repository.dart';

abstract class AmplifyGetTokenUsecase extends SharedBaseUsecaseOutput<String> {}

class AmplifyGetTokenUsecaseImp implements AmplifyGetTokenUsecase {
  final AmplifyRepository _amplifyRepository;

  AmplifyGetTokenUsecaseImp({
    required AmplifyRepository amplifyRepository,
  }) : _amplifyRepository = amplifyRepository;

  @override
  AsyncResult<String, RestFailure> call() async =>
      await _amplifyRepository.getToken();
}
