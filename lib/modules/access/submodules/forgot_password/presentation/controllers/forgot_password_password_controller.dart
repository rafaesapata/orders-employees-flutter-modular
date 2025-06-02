import 'package:flutter/material.dart';

import '../../../../../../app/app_localization.dart';
import '../../../../../shared/domain/bases/shared_base_controller.dart';
import '../../../../../shared/domain/enums/shared_enum_page_state.dart';
import '../../../../../shared/domain/extensions/shared_extensions_rest_failure.dart';
import '../../../../../shared/domain/validators/variations/shared_validators_character_special.dart';
import '../../../../../shared/domain/validators/variations/shared_validators_combo.dart';
import '../../../../../shared/domain/validators/variations/shared_validators_compare_password.dart';
import '../../../../../shared/domain/validators/variations/shared_validators_has_numbers.dart';
import '../../../../../shared/domain/validators/variations/shared_validators_minimum_quantity.dart';
import '../../../../../shared/domain/validators/variations/shared_validators_number_sequence.dart';
import '../../../../../shared/domain/validators/variations/shared_validators_uppercase_lowercase.dart';
import '../../domain/dtos/forgot_password_new_password_dto.dart';
import '../../domain/usecases/forgot_password_new_password_usecase.dart';

abstract class ForgotPasswordPasswordController extends SharedBaseController {
  TextEditingController get passwordController;
  TextEditingController get confirmController;
  List<SharedValidatorsCombo> get validators;
  void verifyEnabled();
  Future<bool> resetPassword();
}

class ForgotPasswordPasswordControllerImp
    extends ForgotPasswordPasswordController {
  final ForgotPasswordNewPasswordUsecase _forgotPasswordNewPasswordUsecase;

  @override
  final confirmController = TextEditingController();

  @override
  final passwordController = TextEditingController();

  @override
  final validators = <SharedValidatorsCombo>[
    SharedValidatorsMinimumQuantity(
      Localization.tr.passwordValidationsAtLeastEight,
      8,
    ),
    SharedValidatorsSpecialChar(
      Localization.tr.passwordValidationsSpecialCharacter,
    ),
    SharedValidatorsUpperCaseLowercase(
      Localization.tr.passwordValidationsUpperCaseLowerCase,
    ),
    SharedValidatorsHasNumbers(
      Localization.tr.passwordValidationsNumbers,
    ),
    SharedValidatorsNumberSequence(
      Localization.tr.passwordValidationsSequencialNumbers,
    ),
    SharedValidatorsComparePassword(
      Localization.tr.passwordValidationsComparePassword,
    ),
  ];

  ForgotPasswordPasswordControllerImp({
    required ForgotPasswordNewPasswordUsecase forgotPasswordNewPasswordUsecase,
  }) : _forgotPasswordNewPasswordUsecase = forgotPasswordNewPasswordUsecase;

  @override
  void verifyEnabled() => isValid.value = !validators.any(
        (e) => e is SharedValidatorsComparePassword
            ? !e.validate(passwordController.text, confirmController.text)
            : !e.validate(passwordController.text, null),
      );

  @override
  Future<bool> resetPassword() async {
    pageState.value = SharedEnumPageState.loading;
    final request =
        ForgotPasswordNewPasswordDTO(password: passwordController.text);
    final result = await _forgotPasswordNewPasswordUsecase(request);
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
