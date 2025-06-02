import '../../domain/dtos/forgot_password_new_password_dto.dart';
import '../../domain/dtos/forgot_password_request_code_dto.dart';
import '../../domain/dtos/forgot_password_validate_code_dto.dart';

abstract class ForgotPasswordDatasource {
  Future<void> requestCode(ForgotPasswordRequestCodeDTO request);
  Future<void> validateCode(ForgotPasswordValidateCodeDTO request);
  Future<void> newPassword(ForgotPasswordNewPasswordDTO request);
}
