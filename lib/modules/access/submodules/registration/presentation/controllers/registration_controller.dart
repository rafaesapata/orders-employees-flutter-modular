import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../app/app_localization.dart';
import '../../../../../shared/domain/bases/shared_base_controller.dart';
import '../../../../../shared/domain/enums/shared_enum_page_state.dart';
import '../../domain/dtos/registration_dto.dart';
import '../../domain/usecases/make_registration_use_case.dart';
import 'registration_contact_controller.dart';
import 'registration_password_controller.dart';
import 'registration_user_data_controller.dart';

abstract class RegistrationController extends SharedBaseController {
  PageController get pageController;
  ValueNotifier<RegistrationDTO?> get registrationData;
  ValueNotifier<int> get currentIndex;
  ValueNotifier<String> get continueButtonText;
  void onBackPressed();
  void onNextPressed();
}

class RegistrationControllerImp extends RegistrationController {
  final MakeRegistrationUseCase _makeRegistrationUseCase;
  final RegistrationUserDataController _registrationUserDataController;
  final RegistrationContactController _registrationContactController;
  final RegistrationPasswordController _registrationPasswordController;

  @override
  final pageController = PageController(keepPage: true);

  @override
  final registrationData = ValueNotifier<RegistrationDTO?>(null);

  @override
  final currentIndex = ValueNotifier<int>(0);

  @override
  final continueButtonText =
      ValueNotifier<String>(Localization.tr.commonContinue);

  RegistrationControllerImp({
    required MakeRegistrationUseCase makeRegistrationUseCase,
    required RegistrationUserDataController registrationUserDataController,
    required RegistrationContactController registrationContactController,
    required RegistrationPasswordController registrationPasswordController,
  })  : _makeRegistrationUseCase = makeRegistrationUseCase,
        _registrationUserDataController = registrationUserDataController,
        _registrationContactController = registrationContactController,
        _registrationPasswordController = registrationPasswordController;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  void onBackPressed() {
    if (currentIndex.value == 0 ||
        pageState.value.isLoading ||
        pageState.value.isSuccess) {
      Modular.to.pop();
      return;
    }

    currentIndex.value--;
    _navigate();
  }

  @override
  void onNextPressed() {
    switch (currentIndex.value) {
      case 0:
        return _validateUserData();
      case 1:
        return _validateContact();
      case 2:
        return _validatePassword();
    }
  }

  void _navigate() {
    continueButtonText.value = currentIndex.value == 2
        ? Localization.tr.commonFinish
        : Localization.tr.commonContinue;

    pageController.animateToPage(
      currentIndex.value,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void _validateUserData() {
    if (_registrationUserDataController.formKey.currentState?.validate() !=
        true) {
      _registrationUserDataController.hasError = true;
      return;
    }
    currentIndex.value++;
    _navigate();
  }

  void _validateContact() {
    if (_registrationContactController.formKey.currentState?.validate() !=
        true) {
      _registrationContactController.hasError = true;
      return;
    }
    currentIndex.value++;
    _navigate();
  }

  void _validatePassword() async {
    if (_registrationPasswordController.formKey.currentState?.validate() !=
        true) {
      _registrationPasswordController.hasError = true;
      return;
    }
    _register();
  }

  Future<void> _register() async {
    pageState.value = SharedEnumPageState.loading;
    final result = await _makeRegistrationUseCase(
      RegistrationDTO.fromSteps(
        userData: _registrationUserDataController.values,
        contactData: _registrationContactController.values,
        password: _registrationPasswordController.value,
      ),
    );

    result.fold((success) {
      pageState.value = SharedEnumPageState.success;
    }, (error) {
      pageState.value = SharedEnumPageState.error;
    });
  }
}
