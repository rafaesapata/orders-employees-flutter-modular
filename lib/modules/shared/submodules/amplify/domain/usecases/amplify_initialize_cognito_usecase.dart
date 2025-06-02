import 'package:result_dart/result_dart.dart';

import '../../../../domain/bases/shared_base_usecase.dart';
import '../../../rest/domain/failures/rest_failure.dart';
import '../repositories/amplify_repository.dart';

abstract class AmplifyInitializeCognitoUsecase extends SharedBaseUsecase {}

class AmplifyInitializeCognitoUsecaseImp
    implements AmplifyInitializeCognitoUsecase {
  final AmplifyRepository _amplifyRepository;

  AmplifyInitializeCognitoUsecaseImp({
    required AmplifyRepository amplifyRepository,
  }) : _amplifyRepository = amplifyRepository;

  @override
  AsyncResult<Unit, RestFailure> call() async =>
      await _amplifyRepository.initializeCognito();
}
