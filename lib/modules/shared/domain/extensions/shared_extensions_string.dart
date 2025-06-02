import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../presentation/widgets/shared_animation.dart';
import '../../presentation/widgets/shared_icon.dart';
import '../../presentation/widgets/shared_image.dart';
import '../consts/shared_regex.dart';

extension SharedExtensionsString on String {
  String get onlyNumbers => replaceAll(RegExp('\\D+'), '');

  DateTime? toDateTime({String format = 'dd/MM/yyyy'}) {
    try {
      return DateFormat(format).parseStrict(this);
    } catch (_) {
      return null;
    }
  }

  Widget image({
    String? icon,
    BoxFit? fit,
    double? width,
    double? height,
    Function()? onTap,
  }) =>
      SharedImage(
        this,
        fit: fit,
        width: width,
        height: height,
        onTap: onTap,
      );

  Widget icon({
    String? icon,
    BoxFit? fit,
    Color? color,
    double? width,
    double? height,
    double? size,
    Function()? onTap,
  }) =>
      SharedIcon(
        icon: this,
        fit: fit,
        color: color,
        height: height,
        width: width,
        onTap: onTap,
        size: size,
      );

  SharedAnimation animation({
    Key? key,
    String? animation,
    double? height,
    double? width,
    bool? repeat,
    bool? reverse,
    AnimationController? controller,
    BoxFit? fit,
  }) =>
      SharedAnimation(
        animationKey: key,
        animation: this,
        height: height,
        width: width,
        repeat: repeat,
        reverse: reverse,
        controller: controller,
        fit: fit,
      );

  bool get isEmailValid =>
      isNotEmpty && RegExp(SharedRegex.emailRegexp).hasMatch(this);
}

extension AppStringOptionalExtension on String? {
  bool get isNullOrEmpty => this == null || this?.isEmpty == true;
}
