import 'package:diacritic/diacritic.dart';
import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';

abstract class SharedExtensionsToolkit {
  /// Converter o valor de uma String com `R$`
  static double convertCurrencyToDouble(String valor) {
    assert(valor.isNotEmpty);
    final value = double.tryParse(
      valor.replaceAll('R\$', '').replaceAll('.', '').replaceAll(',', '.'),
    );
    return value ?? 0;
  }

  ///converter data em string para string em outro formato
  ///
  ///Exemplo de entrada:
  ///    value: '01/01/2022'
  ///    inputPattern: 'dd/MM/yyyy'
  ///    outputPattern: 'dd MMM yy'
  ///
  ///Saida: '01 Jan 22'
  static String dateFormat({
    required String value,
    required String inputPattern,
    required String outputPattern,
    String locale = 'pt_BR',
  }) {
    final inputFormat = DateFormat(inputPattern);
    final inputDate = inputFormat.parse(value);
    final outputFormat = DateFormat(outputPattern, locale);
    return outputFormat.format(inputDate);
  }

  ///Utilizar 'BR' ou 'US' no parâmetro to
  static String convertDataPattern({
    required String to,
    required String value,
  }) {
    final inputFormat = DateFormat(to == 'BR' ? 'yyyy/MM/dd' : 'dd/MM/yyyy');
    final inputDate = inputFormat.parse(value);
    final outputFormat = DateFormat(to == 'BR' ? 'dd-MM-yyyy' : 'yyyy-MM-dd');
    return outputFormat.format(inputDate);
  }

  ///Converte data ("01/01/2000") para o padrao 01 Jan 2000
  static String convertDataPatternWithMonthExtension(String value) {
    try {
      return DateFormat('dd MMM yyyy')
          .format(DateFormat('dd/MM/yyyy').parse(value).toLocal());
    } catch (e) {
      return value;
    }
  }

  ///query = true se quiser substituir "+" por %2B
  static String patternPhone(String text, bool query) {
    if (text.isEmpty) {
      return '';
    }
    //%2B é o simbolo de + para o back na query.
    String prefix = query ? '%2B' : '+';
    return '${prefix}55${text.replaceAll(RegExp(r'[^\w]+'), '')}';
  }

  static String removeEspecialCharacters(String text) {
    return text.replaceAll(RegExp(r'[^\w\s]+'), '');
  }

  static String clearString(String text) {
    return removeDiacritics(text);
  }

  static String capitalizeFirst(String text) {
    return '${text[0].toUpperCase()}${text.substring(1).toLowerCase()}';
  }

  static String capitalizeFirstOfEach(String text) {
    return text
        .replaceAll(RegExp(' +'), ' ')
        .split(' ')
        .map((str) => capitalizeFirst(str))
        .join(' ');
  }

  static String formatBrDateTime(DateTime date) {
    final formatPart1 = DateFormat('dd', 'pt_BR').format(date.toLocal());
    final formatPart2 =
        capitalizeFirst(DateFormat('MMMM', 'pt_BR').format(date.toLocal()));
    final formatPart3 =
        DateFormat('yyyy, hh:mm', 'pt_BR').format(date.toLocal());

    return [formatPart1, 'de', formatPart2, 'de', formatPart3].join(' ');
  }

  static String formatBrDateTimeWithoutHours(DateTime date) {
    final formatPart1 = DateFormat('dd', 'pt_BR').format(date.toLocal());
    final formatPart2 =
        capitalizeFirst(DateFormat('MMMM', 'pt_BR').format(date.toLocal()));
    final formatPart3 = DateFormat('yyyy', 'pt_BR').format(date.toLocal());

    return [formatPart1, 'de', formatPart2, 'de', formatPart3].join(' ');
  }

  static String formatDateWithoutPreposition(DateTime date) {
    final formatPart1 = DateFormat('dd', 'pt_BR').format(date.toLocal());
    final formatPart2 =
        capitalizeFirst(DateFormat('MMM', 'pt_BR').format(date.toLocal()));
    final formatPart3 = DateFormat('yyyy', 'pt_BR').format(date.toLocal());

    return [formatPart1, formatPart2, formatPart3].join(' ');
  }

  static String formatBrDateShortMY(DateTime date) {
    final formatPart1 = DateFormat('dd', 'pt_BR').format(date.toLocal());
    final formatPart2 =
        capitalizeFirst(DateFormat('MMM', 'pt_BR').format(date.toLocal()));
    final formatPart3 = DateFormat('yy', 'pt_BR').format(date.toLocal());

    return [formatPart1, 'de', formatPart2, 'de', formatPart3].join(' ');
  }

  static String formatBrDateTimeWithoutDays(DateTime date) {
    final formatPart2 =
        capitalizeFirst(DateFormat('MMMM', 'pt_BR').format(date.toLocal()));
    final formatPart3 = DateFormat('yyyy', 'pt_BR').format(date.toLocal());

    return [formatPart2, 'de', formatPart3].join(' ');
  }

  static String formatBrDate(DateTime date) {
    final format = DateFormat('dd/MM/yyyy', 'pt_BR');
    return format.format(date.toLocal());
  }

  static String formatOnlyDateEn(DateTime date) {
    final format = DateFormat('yyyy-MM-dd', 'pt_BR');
    return format.format(date.toLocal());
  }

  static String formatStringBrDate(String dateEn) {
    return dateEn.split('/').reversed.join('-');
  }

  ///Não considera ano bissexto
  static int calculateAge(DateTime date) {
    final days = DateTime.now().difference(date.toLocal()).inDays;
    return (days / 365).floor();
  }

  static String getObjValue(dynamic obj, int propIndex, List propArr) {
    final prop = propArr[propIndex];
    if (propIndex == propArr.length - 1) {
      return obj[prop].toString().toLowerCase();
    } else {
      return getObjValue(obj[prop], propIndex + 1, propArr);
    }
  }

  static List<T> orderList<T>(String order, String fieldOrder, List<T> list) {
    final propArr = fieldOrder.split('.');
    return list
      ..sort((a, b) {
        final mapA = (a as dynamic).toMap();
        final mapB = (b as dynamic).toMap();
        final valueA = getObjValue(mapA, 0, propArr);
        final valueB = getObjValue(mapB, 0, propArr);
        if (order == 'asc') {
          return valueA.compareTo(valueB);
        } else {
          return valueB.compareTo(valueA);
        }
      });
  }

  static String formatDoubleToMoney(double value, {bool withSign = false}) {
    final formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');
    if (withSign) {
      if (value.isNegative) {
        return '- ${formatter.format(value)}';
      }
    }
    return formatter.format(value);
  }

  static String showBalance(double value, {bool showValue = true}) {
    if (showValue) {
      return formatDoubleToMoney(value);
    }
    return '******';
  }

  static String formatBrDateTimeToTime(DateTime date) {
    final format = DateFormat('HH:mm', 'pt_BR');
    return format.format(date.toLocal());
  }

  static String formatDate(DateTime date, {String format = 'yyyy-MM-dd'}) {
    final dateFormat = DateFormat(format, 'pt_br');
    return dateFormat.format(date);
  }

  static String formatBrDateInFull(DateTime date) {
    final format = DateFormat('dd/MMM/yy', 'pt_BR');
    final dateFormat = format.format(date.toLocal());
    return dateFormat.replaceAll('/', ' de ');
  }

  static String formatDateInBrDateTime(DateTime date) {
    final format = DateFormat('dd/MM/yyyy - HH:mm', 'pt_BR');
    return format.format(date.toLocal());
  }

  static String formatDateInBrDateTimeUtc(DateTime date) {
    final format = DateFormat('dd/MM/yyyy - HH:mm', 'pt_BR');
    return format.format(date.toUtc());
  }

  static String removeAllCharactersExceptNumbers(String number) {
    return number.replaceAll(RegExp(r'[^0-9.]+'), '');
  }

  static String onlyNumbers(String number) {
    return number.replaceAll(RegExp(r'[^0-9]'), '');
  }

  static String phoneNumber(String number) {
    if (number.isEmpty) return '';
    final phone = number.replaceAll(RegExp(r'[^0-9]'), '');
    return '+55$phone';
  }

  static String formatCep(String cep) {
    final cepFormatted = '${cep.substring(0, 5)}-${cep.substring(5, 8)}';

    return cepFormatted;
  }

  static double formatMoneyToDouble(String money) {
    final moneyFormat = money.replaceAll('.', '').replaceAll(',', '.');
    return double.parse(moneyFormat);
  }

  static String formatCpfCnpj(String? number) {
    if (number == null) {
      return '';
    }

    final value = onlyNumbers(number);
    if (value.length == 11) {
      return value.replaceAllMapped(
        RegExp(r'(\d{3})(\d{3})(\d{3})(\d{2})'),
        (match) =>
            '''${match.group(1)}.${match.group(2)}.${match.group(3)}-${match.group(4)}''',
      );
    }

    if (value.length == 14) {
      return value.replaceAllMapped(
        RegExp(r'(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})'),
        (match) =>
            '''${match.group(1)}.${match.group(2)}.${match.group(3)}/${match.group(4)}-${match.group(5)}''',
      );
    }

    return number;
  }

  static String formatPhone(
    String number, {
    bool removeSpecialCharacters = true,
  }) {
    String phone = number;
    if (removeSpecialCharacters) {
      phone = removeAllCharactersExceptNumbers(number);
    }
    if (phone.isEmpty || phone.length < 8) {
      return phone;
    }
    if (phone.startsWith('55')) {
      phone = phone.substring(2);
    }
    if ([13, 14, 15].contains(phone.length) && phone.startsWith('0')) {
      phone = phone.substring(3);
    }
    if (phone.startsWith('0')) {
      phone = phone.substring(1);
    }

    if (phone.length == 8) {
      return phone.replaceAllMapped(RegExp(r'(\d{4})(\d{4})'), (match) {
        return '${match.group(1)}-${match.group(2)}';
      });
    } else if (phone.length == 9) {
      return phone.replaceAllMapped(RegExp(r'(\d{5})(\d{4})'), (match) {
        return '${match.group(1)}-${match.group(2)}';
      });
    } else if (phone.length == 10) {
      return phone.replaceAllMapped(RegExp(r'(\d{2})(\d{4})(\d{4})'), (match) {
        return '(${match.group(1)}) ${match.group(2)}-${match.group(3)}';
      });
    } else if (phone.length == 11) {
      return phone.replaceAllMapped(RegExp(r'(\d{2})(\d{5})(\d{4})'), (match) {
        return '(${match.group(1)}) ${match.group(2)}-${match.group(3)}';
      });
    }
    return number;
  }

  static String monthName(int month) {
    switch (month) {
      case DateTime.january:
        return 'Janeiro';
      case DateTime.february:
        return 'Fevereiro';
      case DateTime.march:
        return 'Março';
      case DateTime.april:
        return 'Abril';
      case DateTime.may:
        return 'Maio';
      case DateTime.june:
        return 'Junho';
      case DateTime.july:
        return 'Julho';
      case DateTime.august:
        return 'Agosto';
      case DateTime.september:
        return 'Setembro';
      case DateTime.october:
        return 'Outubro';
      case DateTime.november:
        return 'Novembro';
      case DateTime.december:
        return 'Dezembro';
      default:
        return '';
    }
  }

  static Future<DateTime> getCurrentTime() async =>
      await NTP.now(lookUpAddress: 'a.st1.ntp.br');

  static String numericOnly(String s, {bool firstWordOnly = false}) {
    var numericOnlyStr = '';

    for (var i = 0; i < s.length; i++) {
      if (isNumericOnly(s[i])) {
        numericOnlyStr += s[i];
      }
      if (firstWordOnly && numericOnlyStr.isNotEmpty && s[i] == ' ') {
        break;
      }
    }

    return numericOnlyStr;
  }

  static bool isNumericOnly(String s) => hasMatch(s, r'^\d+$');

  static bool hasMatch(String? value, String pattern) {
    return (value == null) ? false : RegExp(pattern).hasMatch(value);
  }
}
