import 'package:flutter/material.dart';

import '../../../../app/app_localization.dart';
import '../../domain/consts/shared_dimens.dart';
import '../../domain/themes/shared_themes_colors.dart';
import '../../domain/themes/shared_themes_typography.dart';
import '../widgets/buttons/shared_elevated_button.dart';

Future<bool?> showConfirmBottomSheet({
  required BuildContext context,
  bool isDismissible = true,
  bool enableDrag = true,
  Widget? icon,
  String? title,
  String? message,
  String? confirmText,
  String? cancelText,
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
}) async =>
    await showModalBottomSheet<bool>(
      context: context,
      enableDrag: enableDrag,
      isDismissible: isDismissible,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(SharedDimens.medium),
          topRight: Radius.circular(SharedDimens.medium),
        ),
      ),
      builder: (BuildContext context) => _SharedConfirmBottomSheetWidget(
        icon: icon,
        title: title ?? Localization.tr.commonDoYouWantToContinue,
        message: message ?? Localization.tr.commonDoYouWantToContinueMessage,
        confirmText: confirmText ?? Localization.tr.commonConfirm,
        onConfirm: onConfirm,
        cancelText: cancelText,
        onCancel: onCancel,
        canPop: isDismissible,
      ),
    );

class _SharedConfirmBottomSheetWidget extends StatelessWidget {
  final String title;
  final String message;
  final bool canPop;
  final Widget? icon;
  final String? confirmText;
  final String? cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  const _SharedConfirmBottomSheetWidget({
    required this.title,
    required this.message,
    this.canPop = true,
    this.onConfirm,
    this.icon,
    this.confirmText,
    this.cancelText,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) => PopScope(
        canPop: canPop,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: SharedDimens.mediumExtra,
            vertical: SharedDimens.largeExtra,
          ),
          decoration: BoxDecoration(
            color: SharedColors.background,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(SharedDimens.large),
              topRight: Radius.circular(SharedDimens.large),
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  icon ??
                      Icon(
                        Icons.info_outline_rounded,
                        color: SharedColors.iconPrimary,
                        size: SharedDimens.huge,
                      ),
                  const SizedBox(height: SharedDimens.medium),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: SharedTypography.h600.copyWith(
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
                    label: confirmText ?? Localization.tr.commonConfirm,
                    onPressed: () {
                      Navigator.pop(context);
                      onConfirm?.call();
                    },
                  ),
                  const SizedBox(height: SharedDimens.medium),
                  SharedElevatedButton(
                    label: cancelText ?? Localization.tr.commonCancel,
                    onPressed: () {
                      Navigator.pop(context);
                      onCancel?.call();
                    },
                  ),
                  const SizedBox(height: SharedDimens.mediumExtra),
                ],
              ),
            ),
          ),
        ),
      );
}
