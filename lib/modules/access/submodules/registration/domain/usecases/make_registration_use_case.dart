import 'package:result_dart/result_dart.dart';

import '../../../../../shared/domain/bases/shared_base_usecase.dart';
import '../../../../../shared/submodules/rest/domain/failures/rest_failure.dart';
import '../dtos/registration_dto.dart';
import '../repositories/registration_repository.dart';

abstract class MakeRegistrationUseCase
    extends SharedBaseUsecaseInput<RegistrationDTO> {}

class MakeRegistrationUseCaseImp implements MakeRegistrationUseCase {
  final RegistrationRepository _registrationRepository;

  MakeRegistrationUseCaseImp({
    required RegistrationRepository registrationRepository,
  }) : _registrationRepository = registrationRepository;

  @override
  AsyncResult<Unit, RestFailure> call(RegistrationDTO registration) async =>
      await _registrationRepository.register(registration);
}
