import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../app/app_localization.dart';
import '../../../../../shared/domain/consts/shared_dimens.dart';
import '../../../../../shared/domain/themes/shared_themes_colors.dart';
import '../../../../../shared/domain/themes/shared_themes_typography.dart';
import '../../../../../shared/presentation/components/shared_confirm_bottom_sheet.dart';
import '../../../../../shared/presentation/widgets/buttons/shared_continue_button.dart';
import '../../../../../shared/presentation/widgets/buttons/shared_text_button.dart';
import '../../../../../shared/presentation/widgets/shared_app_bar.dart';
import '../../../../../shared/presentation/widgets/shared_height.dart';
import '../../../../../shared/presentation/widgets/shared_scaffold.dart';
import '../../../../../shared/presentation/widgets/shared_single_child_scroll_view.dart';
import '../../../../../shared/presentation/widgets/shared_text_field.dart';
import '../../../forgot_password/forgot_password_routes.dart';
import '../controllers/login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController controller = Modular.get();

  void _doLogin(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());

    controller.doLogin(
      onRetry: () => showConfirmBottomSheet(
        context: context,
        title: Localization.tr.loginErrorRetryTitle,
        message: Localization.tr.loginErrorRetryMessage,
        confirmText: Localization.tr.commonTryAgain,
        cancelText: Localization.tr.loginForgotPassword,
      ),
    );
  }

  @override
  Widget build(BuildContext context) => SharedScaffold(
        appBar: SharedAppBar(
          title: Localization.tr.login,
          leadingCallback: Navigator.of(context).pop,
        ),
        baseController: controller,
        body: Column(
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
                        Localization.tr.loginTitle,
                        style: SharedTypography.h800.copyWith(
                          color: SharedColors.textPrimary,
                        ),
                      ),
                      const SharedHeight(SharedDimens.small),
                      Text(
                        Localization.tr.loginSubtitle,
                        style: SharedTypography.p200.copyWith(
                          color: SharedColors.textSecondary,
                        ),
                      ),
                      const SharedHeight(SharedDimens.medium),
                      AppTextField(
                        label: Localization.tr.loginLabelEmail,
                        controller: controller.emailController,
                        hintText: Localization.tr.loginPlaceholderEmail,
                        enabled: !controller.isLoading.value,
                        fillColor: null,
                        keyboardType: TextInputType.emailAddress,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      const SharedHeight(SharedDimens.medium),
                      AppTextField(
                        label: Localization.tr.loginLabelPassword,
                        controller: controller.passwordController,
                        isPassword: true,
                        hintText: Localization.tr.loginPlaceholderPassword,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        enabled: !controller.isLoading.value,
                      ),
                      const SharedHeight(SharedDimens.medium),
                      SharedTextButton(
                        text: Localization.tr.loginForgotPassword,
                        onPressed: () => Modular.to.pushNamed(
                            ForgotPasswordRoutes.forgotPasswordEmail),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SharedContinueButton(
              pageStateListenable: controller.pageState,
              enabledListenable: controller.isValid,
              onPressed: () => _doLogin(context),
            ),
          ],
        ),
      );
}
