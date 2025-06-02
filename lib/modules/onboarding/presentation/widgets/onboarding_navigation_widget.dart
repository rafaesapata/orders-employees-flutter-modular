import 'package:flutter/material.dart';

import '../../../shared/domain/consts/shared_dimens.dart';
import '../../../shared/domain/themes/shared_themes_colors.dart';

class OnboardingNavigationWidget extends StatefulWidget {
  final int currentPage;
  final void Function()? previousPage;
  final void Function()? nextPage;

  const OnboardingNavigationWidget({
    super.key,
    required this.currentPage,
    required this.previousPage,
    required this.nextPage,
  });

  @override
  State<OnboardingNavigationWidget> createState() =>
      _OnboardingNavigationWidgetState();
}

class _OnboardingNavigationWidgetState
    extends State<OnboardingNavigationWidget> {
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(
          right: SharedDimens.medium,
          left: SharedDimens.medium,
          bottom: SharedDimens.large,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Visibility(
              visible: widget.currentPage > 0,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: SharedColors.white,
                ),
                onPressed: widget.previousPage,
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.arrow_forward_ios_rounded,
                color: SharedColors.white,
              ),
              onPressed: widget.nextPage,
            ),
          ],
        ),
      );
}
