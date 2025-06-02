import 'package:flutter/material.dart';

import '../../domain/consts/shared_dimens.dart';
import '../../domain/consts/shared_icons.dart';
import '../../domain/extensions/shared_extensions_build_context.dart';
import '../../domain/themes/shared_themes_colors.dart';
import '../../domain/themes/shared_themes_typography.dart';
import 'buttons/shared_elevated_button.dart';

class SharedFullScreenFeedback extends StatelessWidget {
  final Widget icon;
  final String title;
  final String message;
  final String confirmText;
  final VoidCallback? callback;

  const SharedFullScreenFeedback({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    required this.confirmText,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          width: context.width,
          height: context.height,
          color: SharedColors.background,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(SharedDimens.large),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  icon,
                  const SizedBox(height: SharedDimens.largeExtra),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: SharedTypography.h500.copyWith(
                      color: SharedColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: SharedDimens.small),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: SharedTypography.p200.copyWith(
                      color: SharedColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: SharedDimens.largeExtra),
                  SharedElevatedButton(
                    label: confirmText,
                    icon: SharedIcons.arrowRight,
                    onPressed: () {
                      Navigator.pop(context);
                      callback?.call();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
