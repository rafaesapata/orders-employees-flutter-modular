import 'package:flutter/material.dart';

import 'shared_themes_colors.dart';
import '../consts/shared_dimens.dart';
import 'shared_themes_typography.dart';

class SharedThemesButton {
  static ElevatedButtonThemeData elevatedPrimary = ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(
        SharedColors.buttonPrimaryBackground,
      ),
    ),
  );

  static OutlinedButtonThemeData outlinedPrimary = OutlinedButtonThemeData(
    style: ButtonStyle(
      shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SharedDimens.smallExtra),
        ),
      ),
      side: WidgetStateProperty.resolveWith(
        (states) => BorderSide(
          color: SharedColors.buttonPrimaryBorder,
          width: 1.0,
          style: BorderStyle.solid,
        ),
      ),
      foregroundColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.disabled)
            ? SharedColors.buttonPrimaryTextDisabled
            : SharedColors.buttonPrimaryText,
      ),
      overlayColor: WidgetStatePropertyAll<Color>(
        SharedColors.buttonPrimaryBackground,
      ),
      textStyle: WidgetStateProperty.resolveWith(
        (states) => SharedTypography.h300.copyWith(
          color: states.contains(WidgetState.disabled)
              ? SharedColors.buttonPrimaryTextDisabled
              : SharedColors.buttonPrimaryText,
        ),
      ),
    ),
  );

  static OutlinedButtonThemeData outlinedSecondary = OutlinedButtonThemeData(
    style: ButtonStyle(
      shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SharedDimens.smallExtra),
        ),
      ),
      side: WidgetStateProperty.resolveWith(
        (states) => BorderSide(
          color: SharedColors.buttonSecondaryBorder,
          width: 1.0,
          style: BorderStyle.solid,
        ),
      ),
      foregroundColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.disabled)
            ? SharedColors.buttonSecondaryTextDisabled
            : SharedColors.buttonSecondaryText,
      ),
      overlayColor: WidgetStatePropertyAll<Color>(
        SharedColors.buttonSecondaryBackground,
      ),
      textStyle: WidgetStateProperty.resolveWith(
        (states) => SharedTypography.h300.copyWith(
          color: states.contains(WidgetState.disabled)
              ? SharedColors.buttonSecondaryTextDisabled
              : SharedColors.buttonSecondaryText,
        ),
      ),
    ),
  );
}
