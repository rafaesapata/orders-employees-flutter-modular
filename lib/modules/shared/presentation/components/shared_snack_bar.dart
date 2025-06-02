import 'package:flutter/material.dart';

import '../../domain/consts/shared_globals_keys.dart';
import '../../domain/themes/shared_themes_colors.dart';
import '../../domain/themes/shared_themes_typography.dart';

Future<void> showSnackBar({
  required String message,
  Color? backgroundColor,
  Color? textColor,
  VoidCallback? callback,
}) async {
  final snackBar = SnackBar(
    backgroundColor: backgroundColor ?? SharedColors.buttonPrimaryBackground,
    content: Text(
      message,
      style: SharedTypography.h300.copyWith(
        color: textColor ?? SharedColors.buttonPrimaryText,
      ),
    ),
  );

  final scaffoldKey = SharedGlobalsKeys.scaffoldMessengerKey;
  if (scaffoldKey.currentState?.context.mounted == true) {
    await scaffoldKey.currentState!.showSnackBar(snackBar).closed;
    scaffoldKey.currentState!.clearSnackBars();
    callback?.call();
  }
}
