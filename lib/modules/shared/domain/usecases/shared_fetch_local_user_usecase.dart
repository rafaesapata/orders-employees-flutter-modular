import 'package:result_dart/result_dart.dart';

import '../bases/shared_base_usecase.dart';
import '../../submodules/rest/domain/failures/rest_failure.dart';
import '../entities/user_entity.dart';
import '../repositories/shared_repository.dart';

abstract class SharedFetchLocalUserUseCase
    extends SharedBaseUsecaseOutput<UserEntity> {}

class SharedFetchLocalUserUseCaseImp implements SharedFetchLocalUserUseCase {
  final SharedRepository _sharedRepository;

  SharedFetchLocalUserUseCaseImp({
    required SharedRepository sharedRepository,
  }) : _sharedRepository = sharedRepository;

  @override
  AsyncResult<UserEntity, RestFailure> call() async =>
      await _sharedRepository.fetchLocalUserData();
}
