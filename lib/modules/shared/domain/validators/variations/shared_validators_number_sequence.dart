import 'shared_validators_combo.dart';

class SharedValidatorsNumberSequence extends SharedValidatorsCombo {
  SharedValidatorsNumberSequence(super.message);
  @override
  bool validate(String value, String? comparePassword) {
    if (value.isEmpty) return false;
    return !RegExp(
            r'(012|123|234|345|456|567|678|789|0123|1234|2345|3456|4567|5678|6789|7890|987|876|765|654|543|432|321|210)+')
        .hasMatch(value);
  }
}
