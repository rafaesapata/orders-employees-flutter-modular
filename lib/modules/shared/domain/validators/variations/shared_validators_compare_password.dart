import 'shared_validators_combo.dart';

class SharedValidatorsComparePassword extends SharedValidatorsCombo {
  SharedValidatorsComparePassword(super.message);

  @override
  bool validate(String value, String? comparePassword) =>
      value.isEmpty ? false : value == comparePassword;
}
