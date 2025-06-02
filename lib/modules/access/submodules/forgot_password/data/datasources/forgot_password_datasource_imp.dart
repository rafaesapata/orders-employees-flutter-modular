import '../../domain/dtos/forgot_password_new_password_dto.dart';
import '../../domain/dtos/forgot_password_request_code_dto.dart';
import '../../domain/dtos/forgot_password_validate_code_dto.dart';
import 'forgot_password_datasource.dart';

class ForgotPasswordDatasourceImp implements ForgotPasswordDatasource {
  @override
  Future<void> requestCode(ForgotPasswordRequestCodeDTO request) async =>
      await Future.delayed(const Duration(seconds: 1));

  @override
  Future<void> validateCode(ForgotPasswordValidateCodeDTO request) async =>
      await Future.delayed(const Duration(seconds: 1));

  @override
  Future<void> newPassword(ForgotPasswordNewPasswordDTO request) async =>
      await Future.delayed(const Duration(seconds: 1));
}
