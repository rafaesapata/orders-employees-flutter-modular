import 'package:result_dart/result_dart.dart';

import '../bases/shared_base_usecase.dart';
import '../../submodules/rest/domain/failures/rest_failure.dart';
import '../entities/user_entity.dart';
import '../repositories/shared_repository.dart';

abstract class SharedFetchRemoteUserUseCase
    extends SharedBaseUsecaseOutput<UserEntity> {}

class SharedFetchRemoteUserUseCaseImp implements SharedFetchRemoteUserUseCase {
  final SharedRepository _sharedRepository;

  SharedFetchRemoteUserUseCaseImp({
    required SharedRepository sharedRepository,
  }) : _sharedRepository = sharedRepository;

  @override
  AsyncResult<UserEntity, RestFailure> call() async =>
      await _sharedRepository.fetchRemoteUserData();
}
