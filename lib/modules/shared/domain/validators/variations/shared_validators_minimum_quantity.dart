import 'shared_validators_combo.dart';

class SharedValidatorsMinimumQuantity extends SharedValidatorsCombo {
  final int maxSizePassword;

  SharedValidatorsMinimumQuantity(super.message, this.maxSizePassword);

  @override
  bool validate(String value, String? comparePassword) =>
      value.isEmpty ? false : value.length >= maxSizePassword;
}
