import '../../../../../app/app_localization.dart';
import '../../extensions/shared_extensions_string.dart';
import '../shared_validators.dart';

class SharedValidatorsPassword extends SharedValidators {
  final bool required;

  SharedValidatorsPassword({this.required = true});

  @override
  String? validate(String? value) => !required && value.isNullOrEmpty
      ? null
      : !isValidPasswordRange(value ?? '')
          ? Localization.tr.validatorPasswordRangeInvalid
          : !isStrongPassword(value ?? '')
              ? Localization.tr.validatorIsStrongPassword
              : null;
}
