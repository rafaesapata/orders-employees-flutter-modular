import '../../../../../app/app_localization.dart';
import '../../extensions/shared_extensions_string.dart';
import '../shared_validators.dart';

class SharedValidatorsPhone extends SharedValidators {
  final bool required;

  SharedValidatorsPhone({this.required = true});

  @override
  String? validate(String? value) => !required && value.isNullOrEmpty
      ? null
      : isValidPhone(value ?? '')
          ? null
          : Localization.tr.validatorInvalidField;
}
