import 'package:result_dart/result_dart.dart';

import '../../../../../shared/domain/bases/shared_base_usecase.dart';
import '../../../../../shared/submodules/rest/domain/failures/rest_failure.dart';
import '../dtos/forgot_password_validate_code_dto.dart';
import '../repositories/forgot_password_repository.dart';

abstract class ForgotPasswordValidateCodeUsecase
    extends SharedBaseUsecaseInput<ForgotPasswordValidateCodeDTO> {}

class ForgotPasswordValidateCodeUsecaseImp
    implements ForgotPasswordValidateCodeUsecase {
  final ForgotPasswordRepository _forgotPasswordRepository;

  ForgotPasswordValidateCodeUsecaseImp({
    required ForgotPasswordRepository forgotPasswordRepository,
  }) : _forgotPasswordRepository = forgotPasswordRepository;

  @override
  AsyncResult<Unit, RestFailure> call(
          ForgotPasswordValidateCodeDTO param) async =>
      await _forgotPasswordRepository.validateCode(param);
}
