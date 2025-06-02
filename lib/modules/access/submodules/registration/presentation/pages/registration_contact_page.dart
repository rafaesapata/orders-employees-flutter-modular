import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../app/app_localization.dart';
import '../../../../../shared/domain/consts/shared_dimens.dart';
import '../../../../../shared/domain/enums/shared_enum_mask.dart';
import '../../../../../shared/domain/extensions/shared_extensions_build_context.dart';
import '../../../../../shared/domain/themes/shared_themes_colors.dart';
import '../../../../../shared/domain/themes/shared_themes_typography.dart';
import '../../../../../shared/domain/validators/variations/shared_validators_cellphone.dart';
import '../../../../../shared/domain/validators/variations/shared_validators_email.dart';
import '../../../../../shared/domain/validators/variations/shared_validators_phone.dart';
import '../../../../../shared/domain/validators/variations/shared_validators_required.dart';
import '../../../../../shared/presentation/widgets/shared_single_child_scroll_view.dart';
import '../../../../../shared/presentation/widgets/shared_text_field.dart';
import '../controllers/registration_contact_controller.dart';

class RegistrationContactPage extends StatefulWidget {
  const RegistrationContactPage({super.key});

  @override
  State<RegistrationContactPage> createState() =>
      _RegistrationContactPageState();
}

class _RegistrationContactPageState extends State<RegistrationContactPage>
    with AutomaticKeepAliveClientMixin<RegistrationContactPage> {
  final _controller = Modular.get<RegistrationContactController>();

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
                      Localization.tr.registrationContactTitle,
                      style: SharedTypography.h800.copyWith(
                        color: SharedColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: SharedDimens.small),
                    Text(
                      Localization.tr.registrationContactSubtitle,
                      style: SharedTypography.p200.copyWith(
                        color: SharedColors.textSecondary,
                      ),
                    ),
                    AppTextField(
                      margin: const EdgeInsets.only(top: SharedDimens.large),
                      label: Localization.tr.registrationContactFieldEmail,
                      hintText:
                          Localization.tr.registrationContactFieldEmailHint,
                      controller: _controller.emailController,
                      validators: [
                        SharedValidatorsRequired(),
                        SharedValidatorsEmail(),
                      ],
                      textCapitalization: TextCapitalization.none,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (p0) => _controller.validate(),
                    ),
                    AppTextField(
                      margin:
                          const EdgeInsets.only(top: SharedDimens.smallExtra),
                      label: Localization.tr.registrationContactFieldPhone,
                      hintText:
                          Localization.tr.registrationContactFieldPhoneHint,
                      controller: _controller.phoneController,
                      validators: [
                        SharedValidatorsPhone(required: false),
                      ],
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        SharedEnumMask.phone.pattern(),
                      ],
                      isOptional: true,
                      onChanged: (p0) => _controller.validate(),
                    ),
                    AppTextField(
                      margin:
                          const EdgeInsets.only(top: SharedDimens.smallExtra),
                      label: Localization.tr.registrationContactFieldCellphone,
                      hintText:
                          Localization.tr.registrationContactFieldCellphoneHint,
                      controller: _controller.cellphoneController,
                      validators: [
                        SharedValidatorsCellPhone(required: false),
                      ],
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        SharedEnumMask.cellphone.pattern(),
                      ],
                      isOptional: true,
                      onChanged: (p0) => _controller.validate(),
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
