import 'package:flutter/material.dart';

import '../../../../../shared/domain/bases/shared_base_controller.dart';
import '../../../../../shared/domain/enums/shared_enum_page_state.dart';
import '../../../../../shared/domain/extensions/shared_extensions_rest_failure.dart';
import '../../../../../shared/domain/extensions/shared_extensions_string.dart';
import '../../domain/dtos/forgot_password_request_code_dto.dart';
import '../../domain/usecases/forgot_password_request_code_usecase.dart';

abstract class ForgotPasswordEmailController extends SharedBaseController {
  TextEditingController get emailController;
  void verifyEnabled();
  Future<bool> requestCode();
}

class ForgotPasswordEmailControllerImp extends ForgotPasswordEmailController {
  final ForgotPasswordRequestCodeUsecase _forgotPasswordRequestCodeUsecase;

  @override
  final emailController = TextEditingController();

  ForgotPasswordEmailControllerImp({
    required ForgotPasswordRequestCodeUsecase forgotPasswordRequestCodeUsecase,
  }) : _forgotPasswordRequestCodeUsecase = forgotPasswordRequestCodeUsecase;

  @override
  void verifyEnabled() => isValid.value = emailController.text.isEmailValid;

  @override
  Future<bool> requestCode() async {
    pageState.value = SharedEnumPageState.loading;
    final request = ForgotPasswordRequestCodeDTO(email: emailController.text);
    final result = await _forgotPasswordRequestCodeUsecase(request);
    pageState.value = SharedEnumPageState.ready;

    return result.fold(
      (success) => true,
      (failure) {
        this.failure.value = failure.buildData();
        return false;
      },
    );
  }
}
