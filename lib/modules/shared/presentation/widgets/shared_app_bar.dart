import 'package:flutter/material.dart';

import '../../domain/enums/shared_enum_leading_actions.dart';
import '../../domain/themes/shared_themes_colors.dart';
import '../../domain/consts/shared_dimens.dart';
import '../../domain/themes/shared_themes_typography.dart';

class SharedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final VoidCallback? leadingCallback;
  final SharedEnumLeadingActions leadingActionType;
  final List<Widget>? actions;

  const SharedAppBar({
    super.key,
    required this.title,
    this.leading,
    this.leadingCallback,
    this.leadingActionType = SharedEnumLeadingActions.previous,
    this.actions,
  });

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) => AppBar(
        leading: leading ?? _leading(context),
        title: Text(title),
        titleTextStyle: SharedTypography.h500.copyWith(
          color: SharedColors.textPrimary,
        ),
        centerTitle: true,
        actions: actions,
        backgroundColor: SharedColors.background,
        scrolledUnderElevation: 0,
        elevation: 0,
        shadowColor: Colors.transparent,
      );

  Widget? _leading(BuildContext context) =>
      leadingActionType == SharedEnumLeadingActions.none
          ? null
          : IconButton(
              onPressed: leadingCallback ?? () => Navigator.pop(context),
              icon: Icon(
                leadingActionType == SharedEnumLeadingActions.close
                    ? Icons.close
                    : Icons.chevron_left,
                color: SharedColors.iconPrimary,
                size: SharedDimens.largeExtra,
              ),
            );
}
