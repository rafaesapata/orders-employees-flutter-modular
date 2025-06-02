import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

enum SharedEnumMask {
  cpf,
  cnpj,
  phone,
  cellphone,
  date,
  postalCode,
}

extension SharedEnumMaskExtension on SharedEnumMask {
  MaskTextInputFormatter _numberMaskTextInputFormatter(
    String mask,
    String? initialText,
  ) =>
      MaskTextInputFormatter(
        mask: mask,
        initialText: initialText,
        filter: {'#': RegExp(r'[0-9]')},
      );

  TextInputFormatter pattern({String? initialText}) {
    switch (this) {
      case SharedEnumMask.cpf:
        return _numberMaskTextInputFormatter('###.###.###-##', initialText);
      case SharedEnumMask.cnpj:
        return _numberMaskTextInputFormatter('##.###.###/####-##', initialText);
      case SharedEnumMask.phone:
        return _numberMaskTextInputFormatter('(##) ####-####', initialText);
      case SharedEnumMask.cellphone:
        return _numberMaskTextInputFormatter('(##) #####-####', initialText);
      case SharedEnumMask.date:
        return _numberMaskTextInputFormatter('##/##/####', initialText);
      case SharedEnumMask.postalCode:
        return _numberMaskTextInputFormatter('#####-###', initialText);
    }
  }
}
