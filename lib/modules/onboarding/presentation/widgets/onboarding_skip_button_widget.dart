import 'package:flutter/material.dart';

import '../../../../app/app_localization.dart';
import '../../../shared/domain/consts/shared_dimens.dart';
import '../../../shared/domain/themes/shared_themes_colors.dart';
import '../../../shared/presentation/widgets/buttons/shared_text_button.dart';

class OnboardingSkipButton extends StatefulWidget {
  final Function()? onPressed;

  const OnboardingSkipButton({super.key, required this.onPressed});

  @override
  State<OnboardingSkipButton> createState() => _OnboardingSkipButtonState();
}

class _OnboardingSkipButtonState extends State<OnboardingSkipButton> {
  @override
  Widget build(BuildContext context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(SharedDimens.large),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SharedTextButton(
                onPressed: widget.onPressed,
                enabledColor: SharedColors.white,
                text: Localization.tr.commonSkip,
              ),
            ],
          ),
        ),
      );
}
