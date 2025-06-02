import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../../../../../app/app_localization.dart';
import '../../../domain/consts/shared_dimens.dart';
import '../../../domain/consts/shared_icons.dart';
import '../../../domain/enums/shared_enum_page_state.dart';
import 'shared_elevated_button.dart';

class SharedContinueButton extends StatelessWidget {
  final ValueNotifier<SharedEnumPageState> pageStateListenable;
  final ValueNotifier<bool> enabledListenable;
  final VoidCallback onPressed;
  final String? icon;
  final String? label;

  const SharedContinueButton({
    super.key,
    required this.pageStateListenable,
    required this.enabledListenable,
    required this.onPressed,
    this.icon,
    this.label,
  });

  @override
  Widget build(BuildContext context) => SlideInUp(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ListenableBuilder(
              listenable: Listenable.merge([
                pageStateListenable,
                enabledListenable,
              ]),
              builder: (context, child) => Padding(
                padding: const EdgeInsets.only(
                  bottom: SharedDimens.medium,
                  right: SharedDimens.medium,
                ),
                child: SharedElevatedButton(
                  icon: icon ?? SharedIcons.arrowRight,
                  label: label ?? Localization.tr.commonContinue,
                  isLoading: pageStateListenable.value.isLoading,
                  enabled: enabledListenable.value,
                  onPressed: onPressed,
                ),
              ),
            ),
          ],
        ),
      );
}
