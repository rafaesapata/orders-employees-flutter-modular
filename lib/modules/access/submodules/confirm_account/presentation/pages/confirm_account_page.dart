import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../app/app_localization.dart';
import '../../../../../shared/domain/consts/shared_dimens.dart';
import '../../../../../shared/domain/enums/shared_enum_page_state.dart';
import '../../../../../shared/domain/extensions/shared_extensions_build_context.dart';
import '../../../../../shared/domain/themes/shared_themes_colors.dart';
import '../../../../../shared/domain/themes/shared_themes_typography.dart';
import '../../../../../shared/presentation/components/shared_alert_bottom_sheet.dart';
import '../../../../../shared/presentation/widgets/buttons/shared_elevated_button.dart';
import '../../../../../shared/presentation/widgets/buttons/shared_text_button.dart';
import '../../../../../shared/presentation/widgets/shared_app_bar.dart';
import '../../../../../shared/presentation/widgets/shared_height.dart';
import '../../../../../shared/presentation/widgets/shared_pin_code_widget.dart';
import '../../../../../shared/presentation/widgets/shared_scaffold.dart';
import '../../../../../shared/presentation/widgets/shared_single_child_scroll_view.dart';
import '../controllers/confirm_account_controller.dart';

class ConfirmAccountPage extends StatefulWidget {
  const ConfirmAccountPage({super.key});

  @override
  State<ConfirmAccountPage> createState() => _ConfirmAccountPageState();
}

class _ConfirmAccountPageState extends State<ConfirmAccountPage> {
  final _controller = Modular.get<ConfirmAccountController>();

  Future<void> _resendCode() async {
    context.closeKeyboard();
    final result = await _controller.resendCode();
    if (mounted && result == true) {
      showSuccessBottomSheet(
        context: context,
        title: Localization.tr.confirmAccountResendTitle,
        message: Localization.tr.confirmAccountResendMessage,
      );
    }
  }

  Future<void> _confirmAccount() async {
    context.closeKeyboard();
    final result = await _controller.confirmAccount();
    if (result == true) {
      Modular.to.pop(true);
    } else {
      _controller.codeFocusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) => SharedScaffold(
        appBar: SharedAppBar(title: Localization.tr.confirmAccount),
        baseController: _controller,
        body: ListenableBuilder(
          listenable: Listenable.merge([
            _controller.pageState,
            _controller.isValid,
          ]),
          builder: (context, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SharedSingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(SharedDimens.medium),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          Localization.tr.confirmAccountTitle,
                          style: SharedTypography.h800.copyWith(
                            color: SharedColors.textPrimary,
                          ),
                        ),
                        const SharedHeight(SharedDimens.small),
                        Text(
                          Localization.tr.confirmAccountSubtitle,
                          style: SharedTypography.p200.copyWith(
                            color: SharedColors.textSecondary,
                          ),
                        ),
                        const SharedHeight(SharedDimens.small),
                        Text(
                          Localization.tr.confirmAccountTip,
                          style: SharedTypography.p200.copyWith(
                            color: SharedColors.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SharedHeight(SharedDimens.large),
                        SharedPinCodeWidget(
                          controller: _controller.codeController,
                          length: _controller.codeLength,
                          focusNode: _controller.codeFocusNode,
                          hasError: _controller.pageState.value.isError,
                          errorText: Localization.tr.confirmAccountInvalid,
                          onChanged: (p0) => _controller.varifyEnabled(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SharedHeight(SharedDimens.medium),
              SharedElevatedButton(
                label: Localization.tr.confirmAccountVerify,
                width: context.width,
                isLoading: _controller.isLoading.value,
                enabled: _controller.isValid.value,
                margin:
                    const EdgeInsets.symmetric(horizontal: SharedDimens.large),
                onPressed: _confirmAccount,
              ),
              const SharedHeight(SharedDimens.small),
              SharedTextButton(
                text: Localization.tr.confirmAccountResend,
                width: context.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: SharedDimens.large),
                onPressed: _resendCode,
              ),
              const SharedHeight(SharedDimens.medium),
            ],
          ),
        ),
      );
}
