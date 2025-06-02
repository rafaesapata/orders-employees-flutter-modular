import 'package:result_dart/result_dart.dart';

import '../bases/shared_base_usecase.dart';
import '../../submodules/rest/domain/failures/rest_failure.dart';
import '../repositories/shared_repository.dart';

abstract class SharedRequestStoragePermissionUseCase
    extends SharedBaseUsecaseOutput<bool> {}

class SharedRequestStoragePermissionUseCaseImp
    implements SharedRequestStoragePermissionUseCase {
  final SharedRepository _sharedRepository;

  SharedRequestStoragePermissionUseCaseImp({
    required SharedRepository sharedRepository,
  }) : _sharedRepository = sharedRepository;

  @override
  AsyncResult<bool, RestFailure> call() async =>
      await _sharedRepository.requestStoragePermission();
}
