import 'package:flutter/material.dart';

import '../../../shared/domain/consts/shared_dimens.dart';
import '../../../shared/domain/extensions/shared_extensions_string.dart';
import '../../../shared/domain/themes/shared_themes_colors.dart';
import '../../../shared/domain/themes/shared_themes_typography.dart';
import '../../../shared/presentation/widgets/shared_height.dart';
import '../../data/model/onboarding_data_model.dart';

class OnboardingPageViewWidget extends StatefulWidget {
  final List<OnboardingDataModel> pages;
  final PageController pageController;
  final void Function(int)? onPageChanged;

  const OnboardingPageViewWidget({
    super.key,
    required this.pages,
    required this.pageController,
    required this.onPageChanged,
  });

  @override
  State<OnboardingPageViewWidget> createState() =>
      _OnboardingPageViewWidgetState();
}

class _OnboardingPageViewWidgetState extends State<OnboardingPageViewWidget> {
  @override
  Widget build(BuildContext context) => PageView.builder(
        controller: widget.pageController,
        itemCount: widget.pages.length,
        onPageChanged: widget.onPageChanged,
        itemBuilder: (context, index) {
          final page = widget.pages[index];
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: SharedDimens.large,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                page.icon.icon(
                  size: 110,
                  fit: BoxFit.cover,
                  color: SharedColors.white,
                ),
                SharedHeight(SharedDimens.largeExtra),
                Text(
                  page.title,
                  textAlign: TextAlign.center,
                  style: SharedTypography.h800.copyWith(
                    color: SharedColors.white,
                  ),
                ),
                SharedHeight(SharedDimens.medium),
                Text(
                  page.description,
                  textAlign: TextAlign.center,
                  style: SharedTypography.p300.copyWith(
                    color: SharedColors.white,
                  ),
                ),
              ],
            ),
          );
        },
      );
}
