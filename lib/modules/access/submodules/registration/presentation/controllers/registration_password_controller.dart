import 'package:flutter/material.dart';
import '../../../../../../app/app_localization.dart';
import '../../../../../shared/domain/validators/shared_validators.dart';

abstract class RegistrationPasswordController extends ChangeNotifier
    implements SharedValidators {
  GlobalKey<FormState> get formKey;
  TextEditingController get passwordController;
  TextEditingController get passwordConfirmController;
  String get value;
  set hasError(bool hasError);
  void refreshValidate();
  void saveData(Function(String) callback);
}

class RegistrationPasswordControllerImp extends RegistrationPasswordController
    with SharedValidators {
  var _hasError = false;

  @override
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  final passwordConfirmController = TextEditingController();

  @override
  final passwordController = TextEditingController();

  @override
  String get value => passwordController.text;

  @override
  set hasError(bool hasError) => _hasError = hasError;

  @override
  void dispose() {
    passwordController.dispose();
    passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  void refreshValidate() {
    if (!_hasError) return;
    _hasError = formKey.currentState?.validate() != true;
  }

  @override
  String? validate(String? value) => value != passwordController.text
      ? Localization.tr.validatorPasswordDiff
      : null;

  @override
  void saveData(Function(String p1) callback) {
    if (formKey.currentState?.validate() != true) {
      _hasError = true;
      return;
    }
    _hasError = false;
    callback(passwordController.text);
  }
}
