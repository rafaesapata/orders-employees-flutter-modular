import 'package:result_dart/result_dart.dart';

import '../../../../../shared/domain/bases/shared_base_usecase.dart';
import '../../../../../shared/submodules/rest/domain/failures/rest_failure.dart';
import '../dtos/confirm_account_dto.dart';
import '../repositories/confirm_account_repository.dart';

abstract class ConfirmAccountConfirmUsecase
    extends SharedBaseUsecaseInput<ConfirmAccountDTO> {}

class ConfirmAccountConfirmUsecaseImp extends ConfirmAccountConfirmUsecase {
  final ConfirmAccountRepository _confirmAccountRepository;

  ConfirmAccountConfirmUsecaseImp({
    required ConfirmAccountRepository confirmAccountRepository,
  }) : _confirmAccountRepository = confirmAccountRepository;

  @override
  AsyncResult<Unit, RestFailure> call(ConfirmAccountDTO param) async =>
      await _confirmAccountRepository.confirmAccount(param);
}
