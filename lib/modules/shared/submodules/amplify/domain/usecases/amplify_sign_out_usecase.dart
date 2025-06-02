import 'package:result_dart/result_dart.dart';

import '../../../rest/domain/failures/rest_failure.dart';
import '../repositories/amplify_repository.dart';

abstract class AmplifySignOutUsecase {
  AsyncResult<Unit, RestFailure> call();
}

class AmplifySignOutUsecaseImp implements AmplifySignOutUsecase {
  final AmplifyRepository _amplifyRepository;

  AmplifySignOutUsecaseImp({
    required AmplifyRepository amplifyRepository,
  }) : _amplifyRepository = amplifyRepository;

  @override
  AsyncResult<Unit, RestFailure> call() async =>
      await _amplifyRepository.signOut();
}
