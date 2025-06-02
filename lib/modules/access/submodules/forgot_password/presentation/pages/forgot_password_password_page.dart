import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../app/app_localization.dart';
import '../../../../../shared/domain/consts/shared_dimens.dart';
import '../../../../../shared/domain/themes/shared_themes_colors.dart';
import '../../../../../shared/domain/themes/shared_themes_typography.dart';
import '../../../../../shared/presentation/components/shared_alert_bottom_sheet.dart';
import '../../../../../shared/presentation/widgets/buttons/shared_continue_button.dart';
import '../../../../../shared/presentation/widgets/shared_app_bar.dart';
import '../../../../../shared/presentation/widgets/shared_height.dart';
import '../../../../../shared/presentation/widgets/shared_password_validations_widget.dart';
import '../../../../../shared/presentation/widgets/shared_scaffold.dart';
import '../../../../../shared/presentation/widgets/shared_text_field.dart';
import '../../../../access_routes.dart';
import '../../../login/login_routes.dart';
import '../controllers/forgot_password_password_controller.dart';

class ForgotPasswordPasswordPage extends StatefulWidget {
  const ForgotPasswordPasswordPage({super.key});

  @override
  State<ForgotPasswordPasswordPage> createState() =>
      _ForgotPasswordPasswordPageState();
}

class _ForgotPasswordPasswordPageState
    extends State<ForgotPasswordPasswordPage> {
  final _controller = Modular.get<ForgotPasswordPasswordController>();

  Future<void> _resetPassword() async {
    final result = await _controller.resetPassword();
    if (result && mounted) {
      showSuccessBottomSheet(
        context: context,
        title: Localization.tr.commonSuccess,
        message: Localization.tr.forgotPasswordNewPasswordSuccess,
        onConfirm: () {
          final lastPages = [AccessRoutes.access, LoginRoutes.login];
          Modular.to.popUntil((p0) => lastPages.contains(p0.settings.name));
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) => SharedScaffold(
        appBar: SharedAppBar(title: Localization.tr.forgotPasswordTitle),
        baseController: _controller,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(SharedDimens.medium),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Localization.tr.forgotPasswordNewPasswordTitle,
                          style: SharedTypography.h800.copyWith(
                            color: SharedColors.textPrimary,
                          ),
                        ),
                        const SharedHeight(SharedDimens.small),
                        Text(
                          Localization.tr.forgotPasswordNewPasswordSubtitle,
                          style: SharedTypography.p200.copyWith(
                            color: SharedColors.textSecondary,
                          ),
                        ),
                        const SharedHeight(SharedDimens.largeExtra),
                        AppTextField(
                          label: Localization.tr.forgotPasswordNewPasswordLabel,
                          hintText:
                              Localization.tr.forgotPasswordNewPasswordHint,
                          controller: _controller.passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          isPassword: true,
                          onChanged: (p0) => _controller.verifyEnabled(),
                        ),
                        const SharedHeight(SharedDimens.medium),
                        AppTextField(
                          label: Localization
                              .tr.forgotPasswordNewPasswordConfirmLabel,
                          hintText: Localization
                              .tr.forgotPasswordNewPasswordConfirmHint,
                          controller: _controller.confirmController,
                          keyboardType: TextInputType.visiblePassword,
                          isPassword: true,
                          onChanged: (p0) => _controller.verifyEnabled(),
                        ),
                        const SharedHeight(SharedDimens.large),
                        SharedPasswordValidationsWidget(
                          validators: _controller.validators,
                          passwordListenable: _controller.passwordController,
                          confirmPasswordListenable:
                              _controller.confirmController,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SharedContinueButton(
                pageStateListenable: _controller.pageState,
                enabledListenable: _controller.isValid,
                onPressed: _resetPassword,
              ),
            ],
          ),
        ),
      );
}
