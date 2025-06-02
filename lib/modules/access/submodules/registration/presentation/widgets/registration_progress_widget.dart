import 'package:flutter/material.dart';
import '../../../../../shared/domain/consts/shared_dimens.dart';
import '../../../../../shared/domain/extensions/shared_extensions_build_context.dart';
import '../../../../../shared/domain/themes/shared_themes_colors.dart';

class RegistrationProgressWidget extends StatelessWidget {
  final int progressLength;
  final int currentIndex;

  const RegistrationProgressWidget({
    super.key,
    required this.progressLength,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    final results = <Widget>[];
    for (int i = 0; i < progressLength; i++) {
      results.add(
        Container(
          width: context.width / progressLength,
          height: SharedDimens.tiny,
          color: i <= currentIndex
              ? SharedColors.brandDark
              : SharedColors.brandMain,
        ),
      );
    }
    return Row(children: results);
  }
}
