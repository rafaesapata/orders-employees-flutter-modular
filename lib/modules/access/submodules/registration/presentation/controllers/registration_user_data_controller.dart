import 'package:flutter/material.dart';

import '../../../../../shared/presentation/widgets/shared_text_field.dart';
import '../../data/models/registration_user_data_model.dart';
import '../../domain/enums/registration_gender_enum.dart';

abstract class RegistrationUserDataController extends ChangeNotifier {
  GlobalKey<FormState> get formKey;
  int get nameMaxLength;
  TextEditingController get nameController;
  TextEditingController get documentController;
  TextEditingController get birthDateController;
  TextEditingController get genderController;
  List<SharedTextFieldItem> get genderList;
  RegistrationUserDataModel get values;
  set hasError(bool hasError);
  void validate();
}

class RegistrationUserDataControllerImp extends RegistrationUserDataController {
  var _hasError = false;

  @override
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  int get nameMaxLength => 30;

  @override
  final documentController = TextEditingController();

  @override
  final nameController = TextEditingController();

  @override
  final birthDateController = TextEditingController();

  @override
  final genderController = TextEditingController();

  @override
  List<SharedTextFieldItem> get genderList => RegistrationGenderEnum.values
      .map((e) => SharedTextFieldItem(
            id: RegistrationGenderEnum.values.indexOf(e),
            description: e.description,
            item: e,
          ))
      .toList();

  @override
  RegistrationUserDataModel get values => RegistrationUserDataModel(
        name: nameController.text,
        document: documentController.text,
        gender: genderController.text,
      );

  @override
  set hasError(bool hasError) => _hasError = hasError;

  @override
  void dispose() {
    nameController.dispose();
    documentController.dispose();
    birthDateController.dispose();
    genderController.dispose();
    super.dispose();
  }

  @override
  void validate() {
    if (!_hasError) return;
    _hasError = formKey.currentState?.validate() != true;
  }
}
