import 'package:flutter/material.dart';

import '../../../../app/app_localization.dart';
import '../../domain/consts/shared_dimens.dart';
import '../../domain/extensions/shared_extensions_build_context.dart';
import '../../domain/themes/shared_themes_colors.dart';
import '../../domain/themes/shared_themes_typography.dart';
import '../widgets/buttons/shared_elevated_button.dart';

Future<void> showSuccessBottomSheet({
  required BuildContext context,
  String? title,
  String? message,
  String? confirmText,
  VoidCallback? onConfirm,
}) async =>
    await showAlertBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      icon: Icon(
        Icons.check_circle,
        size: SharedDimens.hugeExtra,
        color: SharedColors.success,
      ),
      title: title ?? Localization.tr.commonEverythingWorked,
      message: message ?? Localization.tr.commonEverythingWorkedMessage,
      confirmText: confirmText ?? Localization.tr.commonOk,
      onConfirm: onConfirm,
    );

Future<void> showErrorBottomSheet({
  required BuildContext context,
  Widget? icon,
  String? title,
  String? message,
  String? confirmText,
  VoidCallback? onConfirm,
}) async =>
    await showAlertBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      icon: Icon(
        Icons.error,
        size: SharedDimens.hugeExtra,
        color: SharedColors.error,
      ),
      title: title ?? Localization.tr.commonSomethingWentWrong,
      message: message ?? Localization.tr.commonUnableToCompleteTheOperation,
      confirmText: confirmText ?? Localization.tr.commonOk,
      onConfirm: onConfirm,
    );

Future<void> showAlertBottomSheet({
  required BuildContext context,
  required String message,
  bool isDismissible = true,
  bool enableDrag = true,
  Widget? icon,
  String? title,
  String? confirmText,
  VoidCallback? onConfirm,
}) async =>
    await showModalBottomSheet(
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
      builder: (BuildContext context) => _SharedAlertBottomSheetWidget(
        icon: icon,
        title: title ?? Localization.tr.commonAttention,
        message: message,
        confirmText: confirmText,
        onConfirm: onConfirm,
        canPop: isDismissible,
      ),
    );

class _SharedAlertBottomSheetWidget extends StatelessWidget {
  final String title;
  final String message;
  final bool canPop;
  final Widget? icon;
  final String? confirmText;
  final VoidCallback? onConfirm;

  const _SharedAlertBottomSheetWidget({
    required this.title,
    required this.message,
    this.canPop = true,
    this.onConfirm,
    this.icon,
    this.confirmText,
  });

  @override
  Widget build(BuildContext context) => PopScope(
        canPop: canPop,
        child: Container(
          width: context.width,
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
                    style: SharedTypography.h700.copyWith(
                      color: SharedColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: SharedDimens.medium),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: SharedTypography.p200.copyWith(
                      color: SharedColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: SharedDimens.largeExtra),
                  SharedElevatedButton(
                    width: context.width,
                    label: confirmText ?? Localization.tr.commonOk,
                    onPressed: () {
                      Navigator.pop(context);
                      onConfirm?.call();
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
