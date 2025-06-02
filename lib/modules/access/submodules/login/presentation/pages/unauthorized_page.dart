import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../app/app_localization.dart';
import '../../../../../shared/domain/consts/shared_animations.dart';
import '../../../../../shared/domain/consts/shared_dimens.dart';
import '../../../../../shared/domain/themes/shared_themes_colors.dart';
import '../../../../../shared/domain/themes/shared_themes_typography.dart';
import '../../../../../shared/presentation/widgets/shared_animation.dart';
import '../../../../../shared/presentation/widgets/buttons/shared_elevated_button.dart';
import '../../../../../shared/presentation/widgets/shared_height.dart';
import '../../login_routes.dart';

class UnauthorizedPage extends StatefulWidget {
  const UnauthorizedPage({super.key});
  @override
  State<UnauthorizedPage> createState() => _UnauthorizedPageState();
}

class _UnauthorizedPageState extends State<UnauthorizedPage> {
  @override
  Widget build(BuildContext context) => PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: SharedColors.background,
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: SharedDimens.medium,
              vertical: SharedDimens.large,
            ),
            child: SharedElevatedButton(
              label: Localization.tr.loginUnauthorizedLogin,
              onPressed: () => Modular.to.popUntil(
                ModalRoute.withName(LoginRoutes.login),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: SharedDimens.medium,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SharedAnimation(
                    animation: SharedAnimations.alert,
                    height: 100.0,
                    width: 100.0,
                  ),
                ),
                const SharedHeight(SharedDimens.large),
                Text(
                  Localization.tr.loginUnauthorizedSessionExpired,
                  style: SharedTypography.h800.copyWith(
                    color: SharedColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SharedHeight(SharedDimens.small),
                Text(
                  Localization.tr.loginUnauthorizedSessionExpiredMessage,
                  style: SharedTypography.p200.copyWith(
                    color: SharedColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
}
