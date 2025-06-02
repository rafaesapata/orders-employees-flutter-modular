import 'package:result_dart/result_dart.dart';

import '../../../../../shared/submodules/rest/domain/failures/rest_failure.dart';
import '../dtos/forgot_password_new_password_dto.dart';
import '../dtos/forgot_password_request_code_dto.dart';
import '../dtos/forgot_password_validate_code_dto.dart';

abstract class ForgotPasswordRepository {
  AsyncResult<Unit, RestFailure> requestCode(
      ForgotPasswordRequestCodeDTO request);
  AsyncResult<Unit, RestFailure> validateCode(
      ForgotPasswordValidateCodeDTO request);
  AsyncResult<Unit, RestFailure> newPassword(
      ForgotPasswordNewPasswordDTO request);
}
