import 'shared_validators_combo.dart';

class SharedValidatorsHasNumbers extends SharedValidatorsCombo {
  SharedValidatorsHasNumbers(super.message);

  @override
  bool validate(String value, String? comparePassword) {
    if (value.isEmpty) return false;
    RegExp regex = RegExp(r'\d');

    return regex.hasMatch(value);
  }
}
