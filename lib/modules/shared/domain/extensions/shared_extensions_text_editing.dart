import 'dart:math';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

extension SharedExtensionsTextEditing on TextEditingValue {
  TextEditingValue formatEditUpdate(int decimalDigits) {
    final value = text
        .replaceAll(RegExp(r'[^\d\.,]'), '')
        .replaceFirst(RegExp(r'[\.,]'), 'X')
        .replaceAll(RegExp(r'[\.,]'), '')
        .replaceFirst('X', ',');

    String finalText = value;
    TextSelection newSelection = selection;
    final brPattern = NumberFormat.decimalPattern('pt_BR');

    try {
      double num = brPattern.parse(value).toDouble();
      final decimals = num.remainder(1);
      if (decimals > 0) {
        final regex = '(\\d*,\\d{$decimalDigits})\\d*';
        final valueWithCorrectDecimals =
            value.replaceAllMapped(RegExp(regex), (m) => m[1]!);
        num = brPattern.parse(valueWithCorrectDecimals).toDouble();

        finalText = brPattern
            .format(
              NumberFormat.decimalPattern()
                  .parse(num.toStringAsFixed(decimalDigits)),
            )
            .replaceAll('.', '');
      }
      newSelection = selection.copyWith(
        baseOffset: min(finalText.length, finalText.length + 1),
        extentOffset: min(finalText.length, finalText.length + 1),
      );
    } on FormatException {
      if (finalText.isNotEmpty) {
        finalText = text;
        newSelection = selection;
      }
    }

    return TextEditingValue(
      text: finalText,
      selection: newSelection,
      composing: TextRange.empty,
    );
  }
}
