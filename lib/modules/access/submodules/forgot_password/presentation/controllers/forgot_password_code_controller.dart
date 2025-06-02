import 'package:flutter/material.dart';

import '../../../../../shared/domain/bases/shared_base_controller.dart';
import '../../../../../shared/domain/enums/shared_enum_page_state.dart';
import '../../../../../shared/domain/extensions/shared_extensions_rest_failure.dart';
import '../../../../../shared/presentation/widgets/shared_pin_code_widget.dart';
import '../../domain/dtos/forgot_password_validate_code_dto.dart';
import '../../domain/usecases/forgot_password_validate_code_usecase.dart';

abstract class ForgotPasswordCodeController extends SharedBaseController {
  TextEditingController get pinController;
  SharedPinCodeLengthEnum get pinCodeLength;
  void verifyEnabled();
  Future<bool> validateCode();
}

class ForgotPasswordCodeControllerImp extends ForgotPasswordCodeController {
  final ForgotPasswordValidateCodeUsecase _forgotPasswordValidateCodeUsecase;

  @override
  final pinController = TextEditingController();

  @override
  final pinCodeLength = SharedPinCodeLengthEnum.four;

  ForgotPasswordCodeControllerImp({
    required ForgotPasswordValidateCodeUsecase
        forgotPasswordValidateCodeUsecase,
  }) : _forgotPasswordValidateCodeUsecase = forgotPasswordValidateCodeUsecase;

  @override
  void verifyEnabled() =>
      isValid.value = pinController.text.length == pinCodeLength.value;

  @override
  Future<bool> validateCode() async {
    pageState.value = SharedEnumPageState.loading;
    final request = ForgotPasswordValidateCodeDTO(code: pinController.text);
    final result = await _forgotPasswordValidateCodeUsecase(request);
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
