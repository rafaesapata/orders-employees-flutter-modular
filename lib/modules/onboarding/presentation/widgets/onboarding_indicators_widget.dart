import 'package:flutter/material.dart';

import '../../../shared/domain/consts/shared_dimens.dart';
import '../../../shared/domain/themes/shared_themes_colors.dart';
import '../../data/model/onboarding_data_model.dart';

class OnboardingIndicatorsWidget extends StatefulWidget {
  final List<OnboardingDataModel> pages;
  final int currentPage;

  const OnboardingIndicatorsWidget({
    super.key,
    required this.pages,
    required this.currentPage,
  });

  @override
  State<OnboardingIndicatorsWidget> createState() =>
      _OnboardingIndicatorsWidgetState();
}

class _OnboardingIndicatorsWidgetState
    extends State<OnboardingIndicatorsWidget> {
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: SharedDimens.medium),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.pages.length,
            (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: SharedDimens.tiny),
              width: widget.currentPage == index
                  ? SharedDimens.smallExtra
                  : SharedDimens.small,
              height: widget.currentPage == index
                  ? SharedDimens.smallExtra
                  : SharedDimens.small,
              decoration: BoxDecoration(
                color: widget.currentPage == index
                    ? SharedColors.white
                    : SharedColors.infoLight,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      );
}
