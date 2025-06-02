import 'package:flutter/material.dart';

import '../../domain/consts/shared_dimens.dart';
import '../../domain/themes/shared_themes_colors.dart';
import '../../domain/themes/shared_themes_typography.dart';
import '../../domain/validators/variations/shared_validators_combo.dart';
import 'shared_width.dart';

class SharedPasswordValidationsItemWidget extends StatelessWidget {
  final SharedValidatorsCombo validator;
  final String value;
  final String? comparePassword;

  Color get _textColor => validator.validate(value, comparePassword)
      ? SharedColors.successLight
      : SharedColors.errorLight;

  const SharedPasswordValidationsItemWidget({
    super.key,
    required this.validator,
    required this.value,
    this.comparePassword,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: SharedDimens.small),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: SharedDimens.large,
              width: value.isEmpty ? null : SharedDimens.large,
              margin: value.isEmpty ? null : const EdgeInsets.only(right: 8),
              child: value.isEmpty
                  ? Icon(
                      Icons.arrow_forward_ios,
                      size: SharedDimens.medium,
                      color: SharedColors.iconPrimary,
                    )
                  : validator.validate(value, comparePassword)
                      ? Icon(
                          Icons.check,
                          size: SharedDimens.medium,
                          color: _textColor,
                        )
                      : Icon(
                          Icons.close,
                          size: SharedDimens.medium,
                          color: _textColor,
                        ),
            ),
            const SharedWidth(SharedDimens.small),
            Expanded(
              child: Text(
                validator.message,
                style: SharedTypography.h400.copyWith(
                  fontSize: 16,
                  color: value.isEmpty ? SharedColors.textPrimary : _textColor,
                ),
              ),
            ),
          ],
        ),
      );
}
