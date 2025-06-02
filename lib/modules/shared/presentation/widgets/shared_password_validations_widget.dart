import 'package:flutter/material.dart';

import '../../domain/consts/shared_dimens.dart';
import '../../domain/validators/variations/shared_validators_combo.dart';
import 'shared_height.dart';
import 'shared_password_validations_item_widget.dart';

class SharedPasswordValidationsWidget extends StatelessWidget {
  final List<SharedValidatorsCombo> validators;
  final TextEditingController passwordListenable;
  final TextEditingController confirmPasswordListenable;

  const SharedPasswordValidationsWidget({
    super.key,
    required this.validators,
    required this.passwordListenable,
    required this.confirmPasswordListenable,
  });

  @override
  Widget build(BuildContext context) => ListenableBuilder(
        listenable: Listenable.merge([
          passwordListenable,
          confirmPasswordListenable,
        ]),
        builder: (context, child) => ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: validators.length,
          separatorBuilder: (_, __) => const SharedHeight(SharedDimens.small),
          itemBuilder: (context, i) => SharedPasswordValidationsItemWidget(
            validator: validators[i],
            value: passwordListenable.text,
            comparePassword: confirmPasswordListenable.text,
          ),
        ),
      );
}
