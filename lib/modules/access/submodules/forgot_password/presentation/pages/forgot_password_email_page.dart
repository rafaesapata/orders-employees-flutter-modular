import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../app/app_localization.dart';
import '../../../../../shared/domain/consts/shared_dimens.dart';
import '../../../../../shared/domain/themes/shared_themes_colors.dart';
import '../../../../../shared/domain/themes/shared_themes_typography.dart';
import '../../../../../shared/presentation/widgets/buttons/shared_continue_button.dart';
import '../../../../../shared/presentation/widgets/shared_app_bar.dart';
import '../../../../../shared/presentation/widgets/shared_height.dart';
import '../../../../../shared/presentation/widgets/shared_scaffold.dart';
import '../../../../../shared/presentation/widgets/shared_text_field.dart';
import '../../forgot_password_routes.dart';
import '../controllers/forgot_password_email_controller.dart';

class ForgotPasswordEmailPage extends StatefulWidget {
  const ForgotPasswordEmailPage({super.key});

  @override
  State<ForgotPasswordEmailPage> createState() =>
      _ForgotPasswordEmailPageState();
}

class _ForgotPasswordEmailPageState extends State<ForgotPasswordEmailPage> {
  final _controller = Modular.get<ForgotPasswordEmailController>();

  Future<void> _makeLogin() async {
    final result = await _controller.requestCode();
    if (result) {
      Modular.to.pushNamed(ForgotPasswordRoutes.forgotPasswordCode);
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
                          Localization.tr.forgotPasswordEmailTitle,
                          style: SharedTypography.h800.copyWith(
                            color: SharedColors.textPrimary,
                          ),
                        ),
                        const SharedHeight(SharedDimens.small),
                        Text(
                          Localization.tr.forgotPasswordEmailSubtitle,
                          style: SharedTypography.p200.copyWith(
                            color: SharedColors.textSecondary,
                          ),
                        ),
                        const SharedHeight(SharedDimens.largeExtra),
                        AppTextField(
                          label: Localization.tr.loginLabelEmail,
                          hintText: Localization.tr.loginPlaceholderEmail,
                          controller: _controller.emailController,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (p0) => _controller.verifyEnabled(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SharedContinueButton(
                pageStateListenable: _controller.pageState,
                enabledListenable: _controller.isValid,
                onPressed: _makeLogin,
              ),
            ],
          ),
        ),
      );
}
