import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../app/app_localization.dart';
import '../../../../../shared/domain/consts/shared_dimens.dart';
import '../../../../../shared/domain/consts/shared_icons.dart';
import '../../../../../shared/domain/enums/shared_enum_page_state.dart';
import '../../../../../shared/domain/extensions/shared_extensions_string.dart';
import '../../../../../shared/domain/themes/shared_themes_colors.dart';
import '../../../../../shared/presentation/components/shared_alert_bottom_sheet.dart';
import '../../../../../shared/presentation/components/shared_full_screen_feedback_dialog.dart';
import '../../../../../shared/presentation/widgets/buttons/shared_elevated_button.dart';
import '../../../../../shared/presentation/widgets/shared_app_bar.dart';
import '../controllers/registration_controller.dart';
import '../widgets/registration_progress_widget.dart';
import 'registration_contact_page.dart';
import 'registration_password_page.dart';
import 'registration_user_data_page.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final controller = Modular.get<RegistrationController>();

  final _pages = [
    RegistrationUserDataPage(),
    RegistrationContactPage(),
    RegistrationPasswordPage(),
  ];

  @override
  void initState() {
    super.initState();

    controller.pageState.addListener(() {
      if (controller.pageState.value.isSuccess) {
        _showSuccess();
      } else if (controller.pageState.value.isError) {
        _showError();
      }
    });
  }

  @override
  Widget build(BuildContext context) => PopScope(
        canPop: false,
        child: Stack(
          children: [
            Scaffold(
              appBar: SharedAppBar(
                title: '',
                leadingCallback: controller.onBackPressed,
              ),
              body: _makeBodyContent(),
              backgroundColor: SharedColors.background,
              floatingActionButton: _makeContinueButton(),
            ),
            ValueListenableBuilder(
              valueListenable: controller.pageState,
              builder: (_, value, __) => Visibility(
                visible: value.isLoading,
                child: Container(
                  color: SharedColors.brandDark.withAlpha(51),
                ),
              ),
            ),
          ],
        ),
      );

  Widget _makeBodyContent() => SafeArea(
        child: ListenableBuilder(
          listenable: Listenable.merge([
            controller.currentIndex,
            controller.registrationData,
            controller.pageState,
          ]),
          builder: (_, __) => Column(
            children: [
              Expanded(
                child: PageView(
                  controller: controller.pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: _pages,
                ),
              ),
              RegistrationProgressWidget(
                progressLength: _pages.length + 1,
                currentIndex: controller.currentIndex.value,
              ),
            ],
          ),
        ),
      );

  Widget _makeContinueButton() => AnimatedBuilder(
        animation: Listenable.merge([
          controller.pageState,
          controller.continueButtonText,
        ]),
        builder: (context, child) => SharedElevatedButton(
          icon: SharedIcons.arrowRight,
          label: controller.continueButtonText.value,
          isLoading: controller.pageState.value.isLoading,
          onPressed: () {
            FocusScope.of(context).requestFocus(FocusNode());
            controller.onNextPressed();
          },
        ),
      );

  Future<dynamic> _showSuccess() => showFullScreenFeedbackDialog(
        context: context,
        icon: SharedIcons.check.icon(
          size: SharedDimens.hugeExtra,
          fit: BoxFit.fill,
          color: SharedColors.success,
        ),
        title: Localization.tr.registrationSuccessTitle,
        message: Localization.tr.registrationSuccessMessage,
        confirmText: Localization.tr.registrationSuccessConfirm,
        callback: Modular.to.pop,
      );

  Future<dynamic> _showError() => showErrorBottomSheet(
        context: context,
        title: Localization.tr.commonErrorTitle,
        message: Localization.tr.registrationErrorMessage,
      );
}
