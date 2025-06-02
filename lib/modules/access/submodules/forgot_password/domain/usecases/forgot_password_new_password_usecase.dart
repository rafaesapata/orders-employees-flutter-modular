import 'package:result_dart/result_dart.dart';

import '../../../../../shared/domain/bases/shared_base_usecase.dart';
import '../../../../../shared/submodules/rest/domain/failures/rest_failure.dart';
import '../dtos/forgot_password_new_password_dto.dart';
import '../repositories/forgot_password_repository.dart';

abstract class ForgotPasswordNewPasswordUsecase
    extends SharedBaseUsecaseInput<ForgotPasswordNewPasswordDTO> {}

class ForgotPasswordNewPasswordUsecaseImp
    implements ForgotPasswordNewPasswordUsecase {
  final ForgotPasswordRepository _forgotPasswordRepository;

  ForgotPasswordNewPasswordUsecaseImp({
    required ForgotPasswordRepository forgotPasswordRepository,
  }) : _forgotPasswordRepository = forgotPasswordRepository;

  @override
  AsyncResult<Unit, RestFailure> call(
          ForgotPasswordNewPasswordDTO param) async =>
      await _forgotPasswordRepository.newPassword(param);
}
