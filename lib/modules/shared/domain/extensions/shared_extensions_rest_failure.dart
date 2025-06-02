import 'dart:ui';

import '../../submodules/rest/domain/failures/rest_failure.dart';
import '../../data/models/failure_data_model.dart';
import '../entities/failure_data_entity.dart';
import '../enums/shared_enum_failure_launch_type.dart';

extension SharedExtensionsRestFailure on RestFailure {
  FailureDataEntity buildData({
    String? title,
    String? message,
    VoidCallback? callback,
    SharedEnumFailureLaunchType? launchType,
  }) =>
      FailureDataModel(
        title: title,
        message: message,
        callback: callback,
        launchType: launchType,
      );
}
