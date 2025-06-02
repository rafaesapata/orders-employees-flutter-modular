import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../app/app_localization.dart';
import '../../../../../shared/domain/consts/shared_dimens.dart';
import '../../../../../shared/domain/enums/shared_enum_mask.dart';
import '../../../../../shared/domain/extensions/shared_extensions_build_context.dart';
import '../../../../../shared/domain/themes/shared_themes_colors.dart';
import '../../../../../shared/domain/themes/shared_themes_typography.dart';
import '../../../../../shared/domain/validators/variations/shared_validators_birth_date.dart';
import '../../../../../shared/domain/validators/variations/shared_validators_cpf.dart';
import '../../../../../shared/domain/validators/variations/shared_validators_required.dart';
import '../../../../../shared/presentation/widgets/shared_single_child_scroll_view.dart';
import '../../../../../shared/presentation/widgets/shared_text_field.dart';
import '../controllers/registration_user_data_controller.dart';

class RegistrationUserDataPage extends StatefulWidget {
  const RegistrationUserDataPage({super.key});

  @override
  State<RegistrationUserDataPage> createState() =>
      _RegistrationUserDataPageState();
}

class _RegistrationUserDataPageState extends State<RegistrationUserDataPage>
    with AutomaticKeepAliveClientMixin<RegistrationUserDataPage> {
  final _controller = Modular.get<RegistrationUserDataController>();

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
          child: Form(
            key: _controller.formKey,
            child: SharedSingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(SharedDimens.medium),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Localization.tr.registrationUserDataTitle,
                      style: SharedTypography.h800.copyWith(
                        color: SharedColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: SharedDimens.small),
                    Text(
                      Localization.tr.registrationUserDataSubtitle,
                      style: SharedTypography.p200.copyWith(
                        color: SharedColors.textSecondary,
                      ),
                    ),
                    AppTextField(
                      margin: const EdgeInsets.only(top: SharedDimens.large),
                      label: Localization.tr.registrationUserDataFieldName,
                      hintText:
                          Localization.tr.registrationUserDataFieldNameHint,
                      controller: _controller.nameController,
                      maxLength: _controller.nameMaxLength,
                      validators: [
                        SharedValidatorsRequired(),
                      ],
                      textCapitalization: TextCapitalization.words,
                      onChanged: (_) => _controller.validate(),
                    ),
                    AppTextField(
                      margin:
                          const EdgeInsets.only(top: SharedDimens.smallExtra),
                      label: Localization.tr.registrationUserDataFieldDocument,
                      hintText:
                          Localization.tr.registrationUserDataFieldDocumentHint,
                      controller: _controller.documentController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        SharedEnumMask.cpf.pattern(),
                      ],
                      validators: [
                        SharedValidatorsRequired(),
                        SharedValidatorsCPF(),
                      ],
                      onChanged: (_) => _controller.validate(),
                    ),
                    AppTextField(
                      margin:
                          const EdgeInsets.only(top: SharedDimens.smallExtra),
                      label: Localization.tr.registrationUserDataFieldBirthDate,
                      hintText: Localization
                          .tr.registrationUserDataFieldBirthDateHint,
                      controller: _controller.birthDateController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        SharedEnumMask.date.pattern(),
                      ],
                      validators: [
                        SharedValidatorsRequired(),
                        SharedValidatorsBirthDate(),
                      ],
                      onChanged: (_) => _controller.validate(),
                      isDateField: true,
                    ),
                    AppTextField(
                      margin:
                          const EdgeInsets.only(top: SharedDimens.smallExtra),
                      label: Localization.tr.registrationUserDataFieldGender,
                      hintText:
                          Localization.tr.registrationUserDataFieldGenderHint,
                      controller: _controller.genderController,
                      listItems: _controller.genderList,
                      validators: [
                        SharedValidatorsRequired(),
                      ],
                      onItemSelected: (_) => _controller.validate(),
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
