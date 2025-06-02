import 'package:flutter/material.dart';

import '../enums/shared_enum_failure_launch_type.dart';

abstract class FailureDataEntity {
  final String? title;
  final String message;
  final VoidCallback? callback;
  final SharedEnumFailureLaunchType launchType;

  FailureDataEntity({
    required this.title,
    required this.message,
    required this.callback,
    required this.launchType,
  });
}
