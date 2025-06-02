import 'package:flutter/material.dart';

import '../../domain/consts/shared_dimens.dart';
import '../../domain/themes/shared_themes_colors.dart';
import '../../domain/themes/shared_themes_typography.dart';

class SharedBottomNavigationBar extends StatefulWidget {
  final List<BottomNavigationBarItem>? items;
  final Function(int)? onPageChanged;
  final EdgeInsets? margin;
  final double? height;
  final BorderRadiusGeometry? borderRadius;
  final BottomNavigationBarType? barType;
  final int currentIndex;

  final Color? backgroundColor;
  final TextStyle? selectedLabelStyle;
  final Color? selectedItemColor;
  final TextStyle? unselectedLabelStyle;
  final Color? unselectedItemColor;

  const SharedBottomNavigationBar({
    super.key,
    this.items,
    this.onPageChanged,
    this.margin,
    this.height,
    this.borderRadius,
    this.barType,
    this.currentIndex = 0,
    this.backgroundColor,
    this.selectedLabelStyle,
    this.selectedItemColor,
    this.unselectedLabelStyle,
    this.unselectedItemColor,
  });

  @override
  State<SharedBottomNavigationBar> createState() =>
      _SharedBottomNavigationBarState();
}

class _SharedBottomNavigationBarState extends State<SharedBottomNavigationBar> {
  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: widget.borderRadius ??
            BorderRadius.circular(SharedDimens.mediumExtra),
        child: SizedBox(
          height: widget.height ?? SharedDimens.bottomBar,
          child: BottomNavigationBar(
            type: widget.barType ?? BottomNavigationBarType.fixed,
            currentIndex: widget.currentIndex,
            backgroundColor: widget.backgroundColor ?? SharedColors.background,
            selectedLabelStyle:
                widget.selectedLabelStyle ?? SharedTypography.h400,
            selectedItemColor:
                widget.selectedItemColor ?? SharedColors.textPrimary,
            unselectedLabelStyle:
                widget.unselectedLabelStyle ?? SharedTypography.h400,
            unselectedItemColor:
                widget.unselectedItemColor ?? SharedColors.textSecondary,
            onTap: (index) => widget.onPageChanged?.call(index),
            items: widget.items ?? [],
          ),
        ),
      );

  Widget makeIcon(Widget icon) => Padding(
        padding: const EdgeInsets.only(bottom: SharedDimens.smallExtra),
        child: icon,
      );
}
