import 'package:flutter/material.dart';

import '../../../domain/consts/shared_dimens.dart';
import '../../../domain/extensions/shared_extensions_string.dart';
import '../../../domain/themes/shared_themes_colors.dart';
import '../../../domain/themes/shared_themes_typography.dart';

class SharedElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final double? width;
  final Color? backgroundColor;
  final Color? borderColor;
  final String? icon;
  final EdgeInsets? margin;
  final bool isLoading;
  final bool enabled;

  const SharedElevatedButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.width,
    this.backgroundColor,
    this.borderColor,
    this.icon,
    this.margin,
    this.isLoading = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) => Container(
        width: width,
        height: SharedDimens.huge,
        margin: margin,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: isLoading
              ? IgnorePointer(
                  ignoring: true,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: _buttonStyle,
                    child: _loadingWidget,
                  ),
                )
              : ElevatedButton.icon(
                  onPressed: enabled ? onPressed : null,
                  style: _buttonStyle,
                  icon: icon?.icon(
                        size: SharedDimens.smallExtra,
                        color: SharedColors.buttonPrimaryIcon,
                      ) ??
                      Container(),
                  label: Text(label),
                ),
        ),
      );

  ButtonStyle get _buttonStyle => ButtonStyle(
        textStyle: WidgetStatePropertyAll(
          SharedTypography.h300.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SharedDimens.huge),
            side: BorderSide(
              color: !enabled
                  ? SharedColors.buttonPrimaryBackgroundDisabled
                  : borderColor ?? SharedColors.buttonPrimaryBorder,
            ),
          ),
        ),
        backgroundColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.disabled)
              ? SharedColors.buttonPrimaryBackgroundDisabled
              : backgroundColor ?? SharedColors.buttonPrimaryBackground,
        ),
        iconColor: WidgetStateProperty.resolveWith(
          (states) => SharedColors.buttonPrimaryIcon,
        ),
        foregroundColor: WidgetStateProperty.resolveWith(
          (states) => SharedColors.buttonPrimaryText,
        ),
      );

  Widget get _loadingWidget => Container(
        margin: const EdgeInsets.symmetric(horizontal: SharedDimens.small),
        width: SharedDimens.large,
        height: SharedDimens.large,
        child: CircularProgressIndicator(color: SharedColors.buttonPrimaryText),
      );
}
