import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_localization.dart';
import '../../domain/consts/shared_dimens.dart';
import '../../domain/extensions/shared_extensions_build_context.dart';

Future<dynamic> showCupertinoDatePicker({
  required BuildContext context,
  required Function(DateTime? selected) callback,
}) async =>
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(SharedDimens.medium),
          topRight: Radius.circular(SharedDimens.medium),
        ),
      ),
      builder: (context) => _SharedCupertinoDatePickerpage(
        callback: callback,
      ),
    );

class _SharedCupertinoDatePickerpage extends StatefulWidget {
  final Function(DateTime? selected) callback;
  const _SharedCupertinoDatePickerpage({required this.callback});

  @override
  State<_SharedCupertinoDatePickerpage> createState() =>
      _SharedCupertinoDatePickerpageState();
}

class _SharedCupertinoDatePickerpageState
    extends State<_SharedCupertinoDatePickerpage> {
  DateTime? _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: SharedDimens.medium,
              top: SharedDimens.tiny,
              right: SharedDimens.medium,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(Localization.tr.commonClose),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    widget.callback(_selectedDate);
                  },
                  child: Text(Localization.tr.commonSelect),
                ),
              ],
            ),
          ),
          SizedBox(
            height: context.height * 0.25,
            child: CupertinoDatePicker(
              onDateTimeChanged: (date) => _selectedDate = date,
              mode: CupertinoDatePickerMode.date,
              minimumYear: DateTime.now().year - 110,
              maximumYear: DateTime.now().year,
            ),
          ),
        ],
      );
}
