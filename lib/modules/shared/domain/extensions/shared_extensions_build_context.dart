import 'package:flutter/material.dart';

extension SharedExtensionsBuildContext on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;

  EdgeInsets get viewPadding => MediaQuery.of(this).viewPadding;
  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;

  bool get isTablet => MediaQuery.of(this).size.shortestSide >= 600;

  void closeKeyboard() => FocusScope.of(this).requestFocus(FocusNode());
}
