import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../domain/consts/shared_dimens.dart';
import '../../domain/extensions/shared_extensions_build_context.dart';
import '../../domain/themes/shared_themes_colors.dart';
import '../../domain/themes/shared_themes_typography.dart';

class SharedPinCodeWidget extends StatelessWidget {
  final void Function(String) onChanged;
  final SharedPinCodeLengthEnum length;
  final TextEditingController? controller;
  final bool? obscureText;
  final FocusNode? focusNode;
  final String? errorText;
  final bool hasError;

  const SharedPinCodeWidget({
    super.key,
    required this.onChanged,
    required this.length,
    required this.controller,
    this.obscureText,
    this.focusNode,
    this.errorText,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PinCodeTextField(
            controller: controller,
            keyboardType: TextInputType.number,
            hintCharacter: '',
            length: length.value,
            errorTextSpace: 0,
            focusNode: focusNode,
            obscureText: obscureText ?? false,
            animationType: AnimationType.scale,
            appContext: context,
            onChanged: onChanged,
            autoFocus: true,
            enableActiveFill: true,
            enablePinAutofill: false,
            autoDisposeControllers: false,
            useExternalAutoFillGroup: false,
            showCursor: obscureText == false,
            cursorColor: SharedColors.textPrimary,
            hintStyle: SharedTypography.h400.copyWith(
              fontSize: SharedDimens.medium,
              color: SharedColors.textFieldHint,
            ),
            textStyle: SharedTypography.h400.copyWith(
              fontSize: SharedDimens.medium,
              color: SharedColors.textPrimary,
            ),
            pinTheme: PinTheme(
              borderWidth: 1,
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(SharedDimens.small),
              fieldHeight: length.height,
              fieldWidth: (context.width / length.value) - length.padding,
              activeFillColor: SharedColors.textFieldBackground,
              inactiveFillColor:
                  hasError ? SharedColors.errorLight : SharedColors.white,
              selectedFillColor: hasError
                  ? SharedColors.errorLight
                  : SharedColors.textFieldBackground,
              activeColor: hasError
                  ? SharedColors.errorLight
                  : SharedColors.textFieldBoder,
              inactiveColor:
                  hasError ? SharedColors.error : SharedColors.textFieldBoder,
              selectedColor: hasError
                  ? SharedColors.error
                  : SharedColors.textFieldBoderFocus,
              disabledColor: hasError
                  ? SharedColors.error
                  : SharedColors.textFieldBoderDisabled,
            ),
          ),
          Visibility(
            visible: hasError && errorText != null,
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                errorText ?? '',
                style: SharedTypography.p200.copyWith(
                  color: SharedColors.error,
                ),
              ),
            ),
          ),
        ],
      );
}

enum SharedPinCodeLengthEnum {
  four,
  six;

  int get value {
    switch (this) {
      case SharedPinCodeLengthEnum.four:
        return 4;
      case SharedPinCodeLengthEnum.six:
        return 6;
    }
  }

  double get height {
    switch (this) {
      case SharedPinCodeLengthEnum.four:
        return SharedDimens.hugeExtra;
      case SharedPinCodeLengthEnum.six:
        return SharedDimens.huge;
    }
  }

  double get padding {
    switch (this) {
      case SharedPinCodeLengthEnum.four:
        return SharedDimens.large;
      case SharedPinCodeLengthEnum.six:
        return SharedDimens.medium;
    }
  }
}
