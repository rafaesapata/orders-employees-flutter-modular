import '../../../../../app/app_localization.dart';
import '../../extensions/shared_extensions_string.dart';
import '../shared_validators.dart';

class SharedValidatorsEmail extends SharedValidators {
  final bool required;

  SharedValidatorsEmail({this.required = true});

  @override
  String? validate(String? value) => !required && value.isNullOrEmpty
      ? null
      : isValidEmail(value ?? '')
          ? null
          : Localization.tr.validatorInvalidField;
}
