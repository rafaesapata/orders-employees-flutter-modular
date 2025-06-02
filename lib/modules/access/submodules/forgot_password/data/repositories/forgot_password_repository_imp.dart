import 'package:result_dart/result_dart.dart';

import '../../../../../shared/submodules/rest/domain/failures/rest_failure.dart';
import '../../../../../shared/submodules/rest/domain/failures/rest_failure_unhandled.dart';
import '../../domain/dtos/forgot_password_new_password_dto.dart';
import '../../domain/dtos/forgot_password_request_code_dto.dart';
import '../../domain/dtos/forgot_password_validate_code_dto.dart';
import '../../domain/repositories/forgot_password_repository.dart';
import '../datasources/forgot_password_datasource.dart';

class ForgotPasswordRepositoryImp implements ForgotPasswordRepository {
  final ForgotPasswordDatasource _forgotPasswordDatasource;

  ForgotPasswordRepositoryImp({
    required ForgotPasswordDatasource forgotPasswordDatasource,
  }) : _forgotPasswordDatasource = forgotPasswordDatasource;

  @override
  AsyncResult<Unit, RestFailure> requestCode(
      ForgotPasswordRequestCodeDTO request) async {
    try {
      await _forgotPasswordDatasource.requestCode(request);
      return unit.toSuccess();
    } on RestFailure catch (e) {
      return e.toFailure();
    } catch (e) {
      return RestFailureUnhandled().toFailure();
    }
  }

  @override
  AsyncResult<Unit, RestFailure> validateCode(
      ForgotPasswordValidateCodeDTO request) async {
    try {
      await _forgotPasswordDatasource.validateCode(request);
      return unit.toSuccess();
    } on RestFailure catch (e) {
      return e.toFailure();
    } catch (e) {
      return RestFailureUnhandled().toFailure();
    }
  }

  @override
  AsyncResult<Unit, RestFailure> newPassword(
      ForgotPasswordNewPasswordDTO request) async {
    try {
      await _forgotPasswordDatasource.newPassword(request);
      return unit.toSuccess();
    } on RestFailure catch (e) {
      return e.toFailure();
    } catch (e) {
      return RestFailureUnhandled().toFailure();
    }
  }
}
