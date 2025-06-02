import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../app/app_localization.dart';
import '../../../../../shared/domain/consts/shared_dimens.dart';
import '../../../../../shared/domain/extensions/shared_extensions_build_context.dart';
import '../../../../../shared/domain/themes/shared_themes_colors.dart';
import '../../../../../shared/domain/themes/shared_themes_typography.dart';
import '../../../../../shared/domain/validators/variations/shared_validators_password.dart';
import '../../../../../shared/domain/validators/variations/shared_validators_required.dart';
import '../../../../../shared/presentation/widgets/shared_single_child_scroll_view.dart';
import '../../../../../shared/presentation/widgets/shared_text_field.dart';
import '../controllers/registration_password_controller.dart';

class RegistrationPasswordPage extends StatefulWidget {
  const RegistrationPasswordPage({super.key});

  @override
  State<RegistrationPasswordPage> createState() =>
      _RegistrationPasswordPageState();
}

class _RegistrationPasswordPageState extends State<RegistrationPasswordPage>
    with AutomaticKeepAliveClientMixin<RegistrationPasswordPage> {
  final _controller = Modular.get<RegistrationPasswordController>();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: SharedColors.background,
      body: GestureDetector(
        onTap: context.closeKeyboard,
        child: SizedBox(
          height: context.height,
          child: SharedSingleChildScrollView(
            child: Form(
              key: _controller.formKey,
              child: Padding(
                padding: const EdgeInsets.all(SharedDimens.medium),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Localization.tr.registrationPasswordTitle,
                      style: SharedTypography.h800.copyWith(
                        color: SharedColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: SharedDimens.small),
                    Text(
                      Localization.tr.registrationPasswordSubtitle,
                      style: SharedTypography.p200.copyWith(
                        color: SharedColors.textSecondary,
                      ),
                    ),
                    AppTextField(
                      margin:
                          const EdgeInsets.only(top: SharedDimens.smallExtra),
                      label: Localization.tr.registrationPasswordPassword,
                      hintText:
                          Localization.tr.registrationPasswordPasswordHint,
                      controller: _controller.passwordController,
                      validators: [
                        SharedValidatorsRequired(),
                        SharedValidatorsPassword(),
                      ],
                      isPassword: true,
                      maxLength: 20,
                      onChanged: (_) => _controller.refreshValidate(),
                    ),
                    AppTextField(
                      margin:
                          const EdgeInsets.only(top: SharedDimens.smallExtra),
                      label: Localization.tr.registrationPasswordConfirmation,
                      hintText:
                          Localization.tr.registrationPasswordConfirmationHint,
                      controller: _controller.passwordConfirmController,
                      validators: [
                        SharedValidatorsRequired(),
                        _controller,
                      ],
                      isPassword: true,
                      maxLength: 20,
                      onChanged: (_) => _controller.refreshValidate(),
                    ),
                    const SizedBox(height: SharedDimens.medium),
                    Text(
                      Localization.tr.registrationPasswordWarn,
                      style: SharedTypography.p100.copyWith(
                        color: SharedColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
