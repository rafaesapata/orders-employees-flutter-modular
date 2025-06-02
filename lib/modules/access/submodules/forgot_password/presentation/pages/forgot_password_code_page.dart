import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../app/app_localization.dart';
import '../../../../../shared/domain/consts/shared_dimens.dart';
import '../../../../../shared/domain/themes/shared_themes_colors.dart';
import '../../../../../shared/domain/themes/shared_themes_typography.dart';
import '../../../../../shared/presentation/widgets/buttons/shared_continue_button.dart';
import '../../../../../shared/presentation/widgets/shared_app_bar.dart';
import '../../../../../shared/presentation/widgets/shared_height.dart';
import '../../../../../shared/presentation/widgets/shared_pin_code_widget.dart';
import '../../../../../shared/presentation/widgets/shared_scaffold.dart';
import '../../forgot_password_routes.dart';
import '../controllers/forgot_password_code_controller.dart';

class ForgotPasswordCodePage extends StatefulWidget {
  const ForgotPasswordCodePage({super.key});

  @override
  State<ForgotPasswordCodePage> createState() => _ForgotPasswordCodePageState();
}

class _ForgotPasswordCodePageState extends State<ForgotPasswordCodePage> {
  final _controller = Modular.get<ForgotPasswordCodeController>();

  Future<void> _validateCode() async {
    final result = await _controller.validateCode();
    if (result) {
      Modular.to.popAndPushNamed(ForgotPasswordRoutes.forgotPasswordPassword);
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
                        SharedPinCodeWidget(
                          controller: _controller.pinController,
                          length: _controller.pinCodeLength,
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
                onPressed: _validateCode,
              ),
            ],
          ),
        ),
      );
}
