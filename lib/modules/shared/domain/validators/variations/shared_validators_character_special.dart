import 'shared_validators_combo.dart';

class SharedValidatorsSpecialChar extends SharedValidatorsCombo {
  SharedValidatorsSpecialChar(super.message);

  @override
  bool validate(String value, String? comparePassword) {
    if (value.isEmpty) return false;
    const specialCharacters = "!@#\$%^&*()_-+={}[]|;:'<>,.?/~";
    for (final char in value.split('')) {
      if (specialCharacters.contains(char)) {
        return true;
      }
    }
    return false;
  }
}
