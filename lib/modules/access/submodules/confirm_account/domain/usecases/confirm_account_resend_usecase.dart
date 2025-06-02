import 'package:result_dart/result_dart.dart';

import '../../../../../shared/domain/bases/shared_base_usecase.dart';
import '../../../../../shared/submodules/rest/domain/failures/rest_failure.dart';
import '../repositories/confirm_account_repository.dart';

abstract class ConfirmAccountResendUsecase extends SharedBaseUsecase {}

class ConfirmAccountResendUsecaseImp extends ConfirmAccountResendUsecase {
  final ConfirmAccountRepository _confirmAccountRepository;

  ConfirmAccountResendUsecaseImp({
    required ConfirmAccountRepository confirmAccountRepository,
  }) : _confirmAccountRepository = confirmAccountRepository;

  @override
  AsyncResult<Unit, RestFailure> call() async =>
      await _confirmAccountRepository.resendCode();
}
