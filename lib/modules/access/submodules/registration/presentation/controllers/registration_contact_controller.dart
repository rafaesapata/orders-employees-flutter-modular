import 'package:flutter/material.dart';

import '../../data/models/registration_contact_model.dart';

abstract class RegistrationContactController extends ChangeNotifier {
  GlobalKey<FormState> get formKey;
  TextEditingController get emailController;
  TextEditingController get phoneController;
  TextEditingController get cellphoneController;
  RegistrationContactModel get values;
  set hasError(bool hasError);
  void validate();
}

class RegistrationContactControllerImp extends RegistrationContactController {
  var _hasError = false;

  @override
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  final emailController = TextEditingController();

  @override
  final phoneController = TextEditingController();

  @override
  final cellphoneController = TextEditingController();

  @override
  set hasError(bool hasError) => _hasError = hasError;

  @override
  RegistrationContactModel get values => RegistrationContactModel(
        email: emailController.text,
        phone: phoneController.text,
        cellphone: cellphoneController.text,
      );

  @override
  void dispose() {
    emailController.dispose();
    phoneController.dispose();
    cellphoneController.dispose();
    super.dispose();
  }

  @override
  void validate() {
    if (!_hasError) return;
    _hasError = formKey.currentState?.validate() != true;
  }
}
