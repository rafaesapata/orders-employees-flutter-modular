import 'package:flutter/material.dart';

import '../../domain/consts/shared_dimens.dart';
import '../../domain/themes/shared_themes_colors.dart';
import '../../domain/themes/shared_themes_typography.dart';

class SharedCheckbox extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final EdgeInsets padding;
  final bool? value;

  const SharedCheckbox({
    super.key,
    required this.text,
    required this.onTap,
    this.padding = EdgeInsets.zero,
    this.value,
  });

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Padding(
          padding: padding,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Theme(
                data: Theme.of(context).copyWith(
                  unselectedWidgetColor: SharedColors.brandLight,
                ),
                child: SizedBox(
                  height: SharedDimens.medium,
                  width: SharedDimens.medium,
                  child: Checkbox(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(SharedDimens.tiny),
                    ),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: value ?? false,
                    activeColor: SharedColors.brandMain,
                    onChanged: (_) => onTap(),
                  ),
                ),
              ),
              const SizedBox(width: SharedDimens.smallExtra),
              Text(
                text,
                style: SharedTypography.p300.copyWith(
                  color: SharedColors.textPrimary,
                ),
              )
            ],
          ),
        ),
      );
}
