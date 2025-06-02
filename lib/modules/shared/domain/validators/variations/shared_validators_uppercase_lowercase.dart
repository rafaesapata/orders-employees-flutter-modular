import 'shared_validators_combo.dart';

class SharedValidatorsUpperCaseLowercase extends SharedValidatorsCombo {
  SharedValidatorsUpperCaseLowercase(super.message);

  @override
  bool validate(String value, String? comparePassword) {
    if (value.isEmpty) return false;
    bool hasUpperCase = false;
    bool hasLowerCase = false;

    for (final char in value.split('')) {
      if (char == char.toUpperCase() && char != char.toLowerCase()) {
        hasUpperCase = true;
      }
      if (char == char.toLowerCase() && char != char.toUpperCase()) {
        hasLowerCase = true;
      }
    }

    return hasUpperCase && hasLowerCase;
  }
}
