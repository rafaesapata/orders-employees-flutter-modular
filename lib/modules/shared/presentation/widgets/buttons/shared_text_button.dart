import 'package:flutter/material.dart';

import '../../../domain/consts/shared_dimens.dart';
import '../../../domain/themes/shared_themes_colors.dart';
import '../../../domain/themes/shared_themes_typography.dart';

class SharedTextButton extends StatelessWidget {
  final String? text;
  final Widget? child;
  final bool enabled;
  final double? width;
  final double? height;
  final EdgeInsets padding;
  final Color? enabledColor;
  final Color? disabledColor;
  final TextStyle? textStyle;
  final VoidCallback? onPressed;
  final Widget? suffix;

  const SharedTextButton({
    super.key,
    this.text,
    this.child,
    this.enabled = true,
    this.width,
    this.height,
    this.padding = EdgeInsets.zero,
    this.enabledColor,
    this.disabledColor,
    this.textStyle,
    this.onPressed,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: padding,
        child: SizedBox(
          width: width,
          height: height ?? SharedDimens.huge,
          child: Material(
            type: MaterialType.transparency,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: !enabled ? null : onPressed ?? () {},
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    child ??
                        Text(
                          text ?? '',
                          style: textStyle ??
                              SharedTypography.h300.copyWith(
                                color: !enabled
                                    ? disabledColor ??
                                        SharedColors.buttonPrimaryTextDisabled
                                    : enabledColor ?? SharedColors.info,
                              ),
                          textAlign: TextAlign.center,
                        ),
                    if (suffix != null) suffix!
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
