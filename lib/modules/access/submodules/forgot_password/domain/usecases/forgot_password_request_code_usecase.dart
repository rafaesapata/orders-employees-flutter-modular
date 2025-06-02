import 'package:result_dart/result_dart.dart';

import '../../../../../shared/domain/bases/shared_base_usecase.dart';
import '../../../../../shared/submodules/rest/domain/failures/rest_failure.dart';
import '../dtos/forgot_password_request_code_dto.dart';
import '../repositories/forgot_password_repository.dart';

abstract class ForgotPasswordRequestCodeUsecase
    extends SharedBaseUsecaseInput<ForgotPasswordRequestCodeDTO> {}

class ForgotPasswordRequestCodeUsecaseImp
    implements ForgotPasswordRequestCodeUsecase {
  final ForgotPasswordRepository _forgotPasswordRepository;

  ForgotPasswordRequestCodeUsecaseImp({
    required ForgotPasswordRepository forgotPasswordRepository,
  }) : _forgotPasswordRepository = forgotPasswordRepository;

  @override
  AsyncResult<Unit, RestFailure> call(
          ForgotPasswordRequestCodeDTO param) async =>
      await _forgotPasswordRepository.requestCode(param);
}
