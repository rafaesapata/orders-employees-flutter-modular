import '../../../../../app/app_localization.dart';
import '../../extensions/shared_extensions_string.dart';
import '../shared_validators.dart';

class SharedValidatorsCPF extends SharedValidators {
  final bool required;

  SharedValidatorsCPF({this.required = true});

  @override
  String? validate(String? value) => !required && value.isNullOrEmpty
      ? null
      : isValidCPF(value ?? '')
          ? null
          : Localization.tr.validatorInvalidField;
}
