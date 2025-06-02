import 'package:flutter/material.dart';

import '../widgets/shared_full_screen_feedback.dart';

Future<dynamic> showFullScreenFeedbackDialog({
  required BuildContext context,
  required Widget icon,
  required String title,
  required String message,
  required String confirmText,
  required VoidCallback? callback,
}) async =>
    await showGeneralDialog(
      context: context,
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) => SharedFullScreenFeedback(
        icon: icon,
        title: title,
        message: message,
        confirmText: confirmText,
        callback: callback,
      ),
    );
