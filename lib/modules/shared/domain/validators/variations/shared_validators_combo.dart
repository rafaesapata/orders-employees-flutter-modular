abstract class SharedValidatorsCombo {
  final String message;
  final String? example;

  SharedValidatorsCombo(this.message, [this.example]);

  bool validate(String value, String? comparePassword);
}
