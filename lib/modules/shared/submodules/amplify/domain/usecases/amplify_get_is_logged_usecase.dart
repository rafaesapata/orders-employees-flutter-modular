import 'package:result_dart/result_dart.dart';

import '../../../../domain/bases/shared_base_usecase.dart';
import '../../../rest/domain/failures/rest_failure.dart';
import '../repositories/amplify_repository.dart';

abstract class AmplifyGetIsLoggedUsecase
    extends SharedBaseUsecaseOutput<bool> {}

class AmplifyGetIsLoggedUsecaseImp extends AmplifyGetIsLoggedUsecase {
  final AmplifyRepository _amplifyRepository;

  AmplifyGetIsLoggedUsecaseImp({
    required AmplifyRepository amplifyRepository,
  }) : _amplifyRepository = amplifyRepository;

  @override
  AsyncResult<bool, RestFailure> call() async =>
      await _amplifyRepository.isLogged();
}
