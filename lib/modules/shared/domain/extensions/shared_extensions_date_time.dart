import 'package:intl/intl.dart';

extension SharedExtensionsDateTime on DateTime {
  String formatted({String format = 'dd/MM/yyyy'}) =>
      DateFormat(format).format(this);
}
