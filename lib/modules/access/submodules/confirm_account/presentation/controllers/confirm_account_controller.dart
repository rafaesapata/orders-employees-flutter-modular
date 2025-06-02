import 'package:flutter/material.dart';

import '../../../../../shared/domain/bases/shared_base_controller.dart';
import '../../../../../shared/domain/enums/shared_enum_page_state.dart';
import '../../../../../shared/domain/extensions/shared_extensions_rest_failure.dart';
import '../../../../../shared/presentation/widgets/shared_pin_code_widget.dart';
import '../../domain/dtos/confirm_account_dto.dart';
import '../../domain/usecases/confirm_account_confirm_usecase.dart';
import '../../domain/usecases/confirm_account_resend_usecase.dart';

abstract class ConfirmAccountController extends SharedBaseController {
  TextEditingController get codeController;
  FocusNode get codeFocusNode;
  SharedPinCodeLengthEnum get codeLength;
  void varifyEnabled();
  Future<bool> resendCode();
  Future<bool> confirmAccount();
}

class ConfirmAccountControllerImp extends ConfirmAccountController {
  final ConfirmAccountConfirmUsecase _confirmAccountConfirmUsecase;
  final ConfirmAccountResendUsecase _confirmAccountResendUsecase;

  ConfirmAccountControllerImp({
    required ConfirmAccountConfirmUsecase confirmAccountConfirmUsecase,
    required ConfirmAccountResendUsecase confirmAccountResendUsecase,
  })  : _confirmAccountConfirmUsecase = confirmAccountConfirmUsecase,
        _confirmAccountResendUsecase = confirmAccountResendUsecase;

  @override
  final codeController = TextEditingController();

  @override
  final codeFocusNode = FocusNode();

  @override
  final codeLength = SharedPinCodeLengthEnum.six;

  @override
  void varifyEnabled() =>
      isValid.value = codeController.text.length == codeLength.value;

  @override
  Future<bool> resendCode() async {
    pageState.value = SharedEnumPageState.loading;
    final result = await _confirmAccountResendUsecase();
    pageState.value = SharedEnumPageState.ready;
    return result.fold(
      (success) => true,
      (failure) {
        this.failure.value = failure.buildData();
        return false;
      },
    );
  }

  @override
  Future<bool> confirmAccount() async {
    pageState.value = SharedEnumPageState.loading;
    final request = ConfirmAccountDTO(code: codeController.text);
    final result = await _confirmAccountConfirmUsecase(request);
    return result.fold(
      (success) => true,
      (failure) {
        pageState.value = SharedEnumPageState.error;
        return false;
      },
    );
  }
}
