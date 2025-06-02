import '../extensions/shared_extensions_string.dart';

abstract mixin class SharedValidators {
  String? validate(String? value);

  bool isValidDate(String date) {
    final instance = date.toDateTime();
    if (instance == null) return false;

    final now = DateTime.now();
    return instance.isAtSameMomentAs(now) || instance.isBefore(now);
  }

  bool isValidEmail(String email) => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);

  bool isValidPhone(String number) =>
      RegExp(r'^[0-9]{10}$').hasMatch(number.onlyNumbers);

  bool isValidCellPhone(String number) =>
      RegExp(r'^[0-9]{11}$').hasMatch(number.onlyNumbers);

  bool isValidCEP(String document) =>
      document.isEmpty || document.trim().length == 8;

  bool isValidCPF(String document) =>
      document.isEmpty || document.trim().length < 11
          ? false
          : _CPFValidator.isValid(document);

  bool isValidPasswordRange(String? password) =>
      (password ?? '').trim().length >= 8 &&
      (password ?? '').trim().length <= 20;

  bool isStrongPassword(String password) => RegExp(
          r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$')
      .hasMatch(password.toString());

  bool hasSequence(String value) => !RegExp(
          r'([a-zA-Z0-9])\1\1\1+|(abcd|bcde|cdef|defg|efgh|fghi|ghij|hijk|ijkl|jklm|klmn|lmno|mnop|nopq|opqr|pqrs|qrst|rstu|stuv|tuvw|uvwx|vwxy|wxyz|0123|1234|2345|3456|4567|5678|6789|7890)+')
      .hasMatch(value.toString());

  bool containNumberAndLetter(String value) =>
      RegExp(r'[a-zA-Z]').hasMatch(value) && RegExp(r'[0-9]').hasMatch(value);

  bool validateMin(dynamic value, int minValue) {
    if (value.runtimeType == String) {
      return value.toString().length >= minValue;
    }
    if (value.runtimeType == double || value.runtimeType == int) {
      return value >= minValue;
    }
    return false;
  }

  bool hasSpace(String value) => value.contains(' ');

  bool isValidRecoverPassword(String? password) {
    if (password == null || password.isEmpty) {
      return false;
    } else if (!validateMin(password, 8)) {
      return false;
    } else if (hasSpace(password)) {
      return false;
    } else if (!containNumberAndLetter(password)) {
      return false;
    } else if (!isStrongPassword(password)) {
      return false;
    }
    return true;
  }
}

class _CPFValidator {
  // ignore: constant_identifier_names
  static const List<String> BLACKLIST = [
    '00000000000',
    '11111111111',
    '22222222222',
    '33333333333',
    '44444444444',
    '55555555555',
    '66666666666',
    '77777777777',
    '88888888888',
    '99999999999',
    '12345678909'
  ];

  // ignore: constant_identifier_names
  static const STRIP_REGEX = r'[^\d]';

  static int _verifierDigit(String cpf) {
    final numbers =
        cpf.split('').map((number) => int.parse(number, radix: 10)).toList();
    final modulus = numbers.length + 1;
    final multiplied = <int>[];
    for (int i = 0; i < numbers.length; i++) {
      multiplied.add(numbers[i] * (modulus - i));
    }
    final mod = multiplied.reduce((buffer, number) => buffer + number) % 11;
    return mod < 2 ? 0 : 11 - mod;
  }

  static String strip(String cpf) {
    String value = cpf;
    final regExp = RegExp(STRIP_REGEX);
    value = cpf.isEmpty ? '' : value;
    return value.replaceAll(regExp, '');
  }

  static bool isValid(String cpf, {bool stripBeforeValidation = true}) {
    String value = cpf;
    if (stripBeforeValidation) value = strip(cpf);
    if (value.isEmpty || value.isEmpty) return false;
    if (value.length != 11) return false;
    if (BLACKLIST.contains(value)) return false;
    String numbers = value.substring(0, 9);
    numbers += _verifierDigit(numbers).toString();
    numbers += _verifierDigit(numbers).toString();
    return numbers.substring(numbers.length - 2) ==
        value.substring(value.length - 2);
  }
}
