import '../../../../../app/app_localization.dart';
import '../../extensions/shared_extensions_string.dart';
import '../shared_validators.dart';

class SharedValidatorsBirthDate extends SharedValidators {
  final bool required;

  SharedValidatorsBirthDate({this.required = true});

  @override
  String? validate(String? value) => !required && value.isNullOrEmpty
      ? null
      : isValidDate(value ?? '')
          ? null
          : Localization.tr.validatorInvalidField;
}
