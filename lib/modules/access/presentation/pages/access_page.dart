import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../app/app_localization.dart';
import '../../../shared/domain/consts/shared_dimens.dart';
import '../../../shared/domain/consts/shared_icons.dart';
import '../../../shared/domain/consts/shared_images.dart';
import '../../../shared/domain/extensions/shared_extensions_string.dart';
import '../../../shared/domain/themes/shared_themes_colors.dart';
import '../../../shared/domain/themes/shared_themes_typography.dart';
import '../../../shared/presentation/widgets/buttons/shared_elevated_button.dart';
import '../../../shared/presentation/widgets/buttons/shared_text_button.dart';
import '../../../shared/presentation/widgets/shared_height.dart';
import '../../submodules/login/login_routes.dart';
import '../../submodules/registration/registration_routes.dart';
import '../controllers/access_controller.dart';

class AccessPage extends StatefulWidget {
  const AccessPage({super.key});
  @override
  State<AccessPage> createState() => _AccessPageState();
}

class _AccessPageState extends State<AccessPage> {
  final AccessController controller = Modular.get();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) => controller.initialize());
  }

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
        ),
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(SharedImages.accessBackground),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Center(
                child: SafeArea(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        const SharedHeight(SharedDimens.large),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: SharedColors.black.withAlpha(127),
                                spreadRadius: 4,
                                blurRadius: 30,
                                offset: Offset.zero,
                              ),
                            ],
                          ),
                          child: SharedIcons.logo.icon(
                            color: SharedColors.white,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          Localization.tr.accessTitle,
                          textAlign: TextAlign.center,
                          style: SharedTypography.h800.copyWith(
                            color: SharedColors.textPrimaryInverted,
                          ),
                        ),
                        const SharedHeight(SharedDimens.hugeExtra),
                        SharedElevatedButton(
                          onPressed: () =>
                              Modular.to.pushNamed(LoginRoutes.login),
                          width: double.infinity,
                          label: Localization.tr.accessAccessApp,
                        ),
                        const SharedHeight(SharedDimens.small),
                        ValueListenableBuilder(
                          valueListenable: controller.featureFlagRegistration,
                          builder: (context, value, child) => Visibility(
                            visible: value,
                            child: SharedTextButton(
                              onPressed: () => Modular.to
                                  .pushNamed(RegistrationRoutes.registration),
                              width: double.infinity,
                              enabledColor: SharedColors.buttonPrimaryText,
                              text: Localization.tr.accessCreateAccount,
                            ),
                          ),
                        ),
                        const SharedHeight(SharedDimens.larger),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
