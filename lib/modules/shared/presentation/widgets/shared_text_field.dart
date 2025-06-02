import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import '../../../../app/app_localization.dart';
import '../../domain/consts/shared_dimens.dart';
import '../../domain/consts/shared_icons.dart';
import '../../domain/consts/shared_regex.dart';
import '../../domain/extensions/shared_extensions_build_context.dart';
import '../../domain/extensions/shared_extensions_date_time.dart';
import '../../domain/extensions/shared_extensions_string.dart';
import '../../domain/themes/shared_themes_colors.dart';
import '../../domain/themes/shared_themes_typography.dart';
import '../../domain/validators/shared_validators.dart';
import '../components/shared_cupertino_date_picker_bottom_sheet.dart';
import 'buttons/shared_elevated_button.dart';
import 'shared_checkbox.dart';

class SharedTextFieldItem {
  final int id;
  final String description;
  final dynamic item;

  SharedTextFieldItem({
    required this.id,
    required this.description,
    required this.item,
  });
}

class AppTextField extends StatefulWidget {
  final Widget? suffixIcon;
  final String? label;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final bool showPrefix;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final TextInputType? keyboardType;
  final int? maxLines;
  final bool autocorrect;
  final TextInputAction? textInputAction;
  final Function(String?)? onChanged;
  final Function(String?)? onSubmitted;
  final String? hintText;
  final bool showMaxLengthCounter;
  final bool enabled;
  final EdgeInsets margin;
  final bool isPassword;
  final List<TextInputFormatter>? inputFormatters;
  final List<SharedTextFieldItem>? listItems;
  final Function(SharedTextFieldItem?)? onItemSelected;
  final List<SharedValidators>? validators;
  final VoidCallback? onFocusLeave;
  final VoidCallback? onFocusOpen;
  final bool? obscureText;
  final Color? fillColor;
  final EdgeInsets? padding;
  final EdgeInsets? contentPadding;
  final EdgeInsets? paddingSuffixIcon;
  final TextAlign? textAlign;
  final String? initialText;
  final bool isDense;
  final bool isOptional;
  final double? height;
  final AutovalidateMode? autovalidateMode;
  final bool isDateField;
  final TextCapitalization textCapitalization;

  const AppTextField({
    super.key,
    this.suffixIcon,
    this.label,
    this.focusNode,
    this.controller,
    this.maxLength,
    this.maxLengthEnforcement,
    this.keyboardType,
    this.autocorrect = true,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.showPrefix = false,
    this.maxLines = 1,
    this.hintText,
    this.showMaxLengthCounter = false,
    this.enabled = true,
    this.margin = EdgeInsets.zero,
    this.isPassword = false,
    this.inputFormatters,
    this.listItems,
    this.onItemSelected,
    this.validators,
    this.onFocusLeave,
    this.onFocusOpen,
    this.obscureText,
    this.fillColor,
    this.padding,
    this.textAlign,
    this.contentPadding,
    this.paddingSuffixIcon,
    this.initialText,
    this.isDense = true,
    this.isOptional = false,
    this.height = SharedDimens.larger,
    this.autovalidateMode,
    this.isDateField = false,
    this.textCapitalization = TextCapitalization.sentences,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final _defaultBorder = const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.transparent),
  );

  late var _obscureText = widget.obscureText != null
      ? widget.obscureText! || widget.isPassword
      : widget.isPassword;
  late final _focusNode = widget.focusNode ?? FocusNode();
  late final _controller =
      widget.controller ?? TextEditingController(text: widget.initialText);

  String? _errorString;
  var _hasFocus = false;
  SharedTextFieldItem? _selectedItem;
  TextSelectionControls? _selectionControls;

  void _closeKeyboard() => FocusScope.of(context).requestFocus(FocusNode());

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(
      () => setState(() {
        _hasFocus = _focusNode.hasFocus;
        if (!_hasFocus) widget.onFocusLeave?.call();
      }),
    );
    _hasFocus = widget.initialText?.isNotEmpty == true;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FocusScope(
        onFocusChange: (value) {
          if (value) widget.onFocusOpen?.call();
        },
        child: Padding(
          padding: widget.margin,
          child: GestureDetector(
            onTap: widget.listItems?.isNotEmpty != true
                ? null
                : () {
                    _closeKeyboard();
                    _showBottomListItems();
                  },
            child: _container,
          ),
        ),
      );

  Widget get _container => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _label,
          const SizedBox(height: SharedDimens.small),
          _textFieldContainer,
          Visibility(
            visible: _errorString != null ||
                (widget.showMaxLengthCounter && widget.maxLength != null),
            child: Padding(
              padding: const EdgeInsets.only(top: SharedDimens.tiny),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Visibility(
                    visible: _errorString != null,
                    child: Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: SharedDimens.tiny,
                          left: SharedDimens.lineExtra,
                        ),
                        child: Text(
                          _errorString?.isNotEmpty == true
                              ? _errorString!
                              : Localization.tr.validatorInvalidField,
                          style: SharedTypography.p200.copyWith(
                            color: SharedColors.errorLight,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible:
                        widget.showMaxLengthCounter && widget.maxLength != null,
                    child: Text(
                      '${_controller.text.length}/${widget.maxLength ?? 0}',
                      style: SharedTypography.p100,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );

  Widget get _label => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.label ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: SharedTypography.h400.copyWith(
              color: SharedColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
          Visibility(
            visible: widget.isOptional,
            child: Padding(
              padding: const EdgeInsets.only(
                left: SharedDimens.tiny,
                top: SharedDimens.tiny,
              ),
              child: Text(
                '(Opicional)',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: SharedTypography.caption.copyWith(
                  color: SharedColors.textFieldLabel,
                  fontWeight: FontWeight.w400,
                  fontSize: SharedDimens.small,
                ),
              ),
            ),
          ),
        ],
      );

  Widget get _textFieldContainer => Row(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: widget.height,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _errorString != null
                          ? SharedColors.errorLight
                          : !widget.enabled
                              ? SharedColors.textFieldBoderDisabled
                              : _hasFocus
                                  ? SharedColors.textFieldBoderFocus
                                  : SharedColors.textFieldBoder,
                    ),
                    color: widget.fillColor,
                    borderRadius:
                        BorderRadius.circular(SharedDimens.smallExtra),
                  ),
                  padding: widget.padding ??
                      EdgeInsets.fromLTRB(
                        SharedDimens.tiny,
                        SharedDimens.lineExtra,
                        widget.isPassword ||
                                widget.suffixIcon != null ||
                                widget.listItems?.isNotEmpty == true
                            ? SharedDimens.huge
                            : SharedDimens.tiny,
                        SharedDimens.none,
                      ),
                  child: Center(child: _textField),
                ),
                Visibility(
                  visible: widget.isPassword ||
                      widget.suffixIcon != null ||
                      widget.listItems?.isNotEmpty == true,
                  child: Positioned.fill(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        height: widget.height,
                        child: _suffixIcon ?? Container(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: widget.isDateField,
            child: _datePickerButton,
          ),
        ],
      );

  TextFormField get _textField => TextFormField(
        key: widget.key,
        enabled: widget.listItems?.isNotEmpty == true ? false : widget.enabled,
        autovalidateMode: widget.autovalidateMode,
        focusNode: _focusNode,
        controller: _controller,
        textAlign: widget.textAlign ?? TextAlign.start,
        maxLines: widget.maxLines,
        maxLength: widget.maxLength,
        maxLengthEnforcement: widget.maxLengthEnforcement,
        keyboardType: widget.keyboardType,
        autocorrect: widget.autocorrect,
        obscureText: _obscureText,
        style:
            SharedTypography.p300.copyWith(color: SharedColors.textFieldText),
        textInputAction: widget.textInputAction,
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onSubmitted,
        textCapitalization: widget.textCapitalization,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle:
              SharedTypography.p300.copyWith(color: SharedColors.textFieldHint),
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          alignLabelWithHint: false,
          disabledBorder: _defaultBorder,
          enabledBorder: _defaultBorder,
          errorBorder: _defaultBorder,
          focusedErrorBorder: _defaultBorder,
          focusedBorder: _defaultBorder,
          border: _defaultBorder,
          filled: true,
          isDense: widget.isDense,
          fillColor: Colors.transparent,
          errorText: null,
          errorStyle: const TextStyle(fontSize: 0.0),
          prefixIcon: null,
          prefixIconConstraints: null,
          prefixIconColor: null,
        ),
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp(SharedRegex.emojiRegexp)),
          ...?widget.inputFormatters
        ],
        validator: _validate,
        buildCounter: (
          BuildContext context, {
          required int currentLength,
          required int? maxLength,
          required bool isFocused,
        }) =>
            null,
        selectionControls: _selectionControls,
      );

  Widget? get _suffixIcon =>
      widget.suffixIcon ??
      (widget.listItems?.isNotEmpty == true
          ? Padding(
              padding: const EdgeInsets.only(right: SharedDimens.smallExtra),
              child: Icon(
                Icons.arrow_drop_down,
                color: SharedColors.iconSecondary,
                size: SharedDimens.largeExtra,
              ),
            )
          : widget.isPassword
              ? Padding(
                  padding: const EdgeInsets.only(right: SharedDimens.medium),
                  child: GestureDetector(
                    onTap: () => setState(() => _obscureText = !_obscureText),
                    child: _obscureText
                        ? SharedIcons.visibilityOn.icon(
                            color: SharedColors.iconSecondary,
                            fit: BoxFit.contain,
                            size: SharedDimens.mediumExtra,
                          )
                        : SharedIcons.visibilityOff.icon(
                            color: SharedColors.iconSecondary,
                            fit: BoxFit.contain,
                            size: SharedDimens.mediumExtra,
                          ),
                  ),
                )
              : null);

  Widget get _datePickerButton => Padding(
        padding: const EdgeInsets.only(left: SharedDimens.small),
        child: Container(
          height: widget.height,
          width: widget.height,
          decoration: BoxDecoration(
            border: Border.all(color: SharedColors.textFieldBoder),
            borderRadius: BorderRadius.circular(
              SharedDimens.smallExtra,
            ),
          ),
          child: InkWell(
            onTap: () async {
              _closeKeyboard();
              await showCupertinoDatePicker(
                context: context,
                callback: (date) {
                  final formatted = date?.formatted() ?? _controller.text;
                  _controller.value = TextEditingValue(
                    text: formatted,
                    selection: TextSelection.fromPosition(
                      TextPosition(offset: formatted.length),
                    ),
                  );
                  widget.onChanged?.call(formatted);
                },
              );
            },
            child: Center(
              child: Icon(
                Icons.calendar_month,
                color: SharedColors.iconSecondary,
              ),
            ),
          ),
        ),
      );

  String? _validate(String? value) {
    if (widget.validators == null) return null;

    List<String> errors = [];
    for (final validator in widget.validators!) {
      var error = validator.validate(value);
      if (error != null) {
        errors.add(error);
      }
    }

    final result = errors.isEmpty ? null : errors.first;
    SchedulerBinding.instance.addPostFrameCallback(
      (_) => setState(() => _errorString = result),
    );
    return result;
  }

  Future<dynamic>? _showBottomListItems() => showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(SharedDimens.smallExtra),
            topRight: Radius.circular(SharedDimens.smallExtra),
          ),
        ),
        builder: (context) => _AppTextFieldBottomSheetList(
          textFieldController: _controller,
          listItems: widget.listItems ?? [],
          selectedItem: _selectedItem,
          callback: (p0) {
            _selectedItem = p0;
            _controller.text = p0?.description ?? '';
            widget.onItemSelected?.call(p0);
          },
        ),
      );
}

class _AppTextFieldBottomSheetList extends StatefulWidget {
  final TextEditingController textFieldController;
  final List<SharedTextFieldItem> listItems;
  final Function(SharedTextFieldItem?) callback;
  final SharedTextFieldItem? selectedItem;

  const _AppTextFieldBottomSheetList({
    required this.textFieldController,
    required this.listItems,
    required this.callback,
    required this.selectedItem,
  });

  @override
  State<_AppTextFieldBottomSheetList> createState() =>
      _AppTextFieldBottomSheetListState();
}

class _AppTextFieldBottomSheetListState
    extends State<_AppTextFieldBottomSheetList> {
  late SharedTextFieldItem? _selectedItem = widget.selectedItem;

  void _setSelectedItem(SharedTextFieldItem item) =>
      setState(() => _selectedItem = _selectedItem == item ? null : item);

  @override
  Widget build(BuildContext context) => Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: SharedDimens.medium),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.listItems
                    .map(
                      (element) => SizedBox(
                        width: context.width,
                        child: SharedCheckbox(
                          text: element.description,
                          padding: const EdgeInsets.fromLTRB(
                            SharedDimens.medium,
                            SharedDimens.small,
                            SharedDimens.medium,
                            SharedDimens.small,
                          ),
                          value: _selectedItem?.id == element.id,
                          onTap: () => _setSelectedItem(element),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          SizedBox(
            width: context.width,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                SharedDimens.medium,
                SharedDimens.mediumExtra,
                SharedDimens.medium,
                SharedDimens.largeExtra,
              ),
              child: SharedElevatedButton(
                label: Localization.tr.commonContinue,
                onPressed: () {
                  Navigator.pop(context);
                  widget.callback(_selectedItem);
                },
              ),
            ),
          )
        ],
      );
}
