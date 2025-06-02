import '../../../../../app/app_localization.dart';
import '../../extensions/shared_extensions_string.dart';
import '../shared_validators.dart';

class SharedValidatorsRequired extends SharedValidators {
  @override
  String? validate(String? value) =>
      value.isNullOrEmpty ? Localization.tr.validatorRequiredField : null;
}
