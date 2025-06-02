import '../../../../../app/app_localization.dart';
import '../../extensions/shared_extensions_string.dart';
import '../shared_validators.dart';

class SharedValidatorsCellPhone extends SharedValidators {
  final bool required;

  SharedValidatorsCellPhone({this.required = true});

  @override
  String? validate(String? value) => !required && value.isNullOrEmpty
      ? null
      : isValidCellPhone(value ?? '')
          ? null
          : Localization.tr.validatorInvalidField;
}
