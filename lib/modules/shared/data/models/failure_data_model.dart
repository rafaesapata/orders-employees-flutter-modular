import '../../../../app/app_localization.dart';
import '../../domain/entities/failure_data_entity.dart';
import '../../domain/enums/shared_enum_failure_launch_type.dart';

class FailureDataModel extends FailureDataEntity {
  FailureDataModel({
    super.title,
    String? message,
    super.callback,
    SharedEnumFailureLaunchType? launchType,
  }) : super(
          message: message ?? Localization.tr.commonSomethingWentWrong,
          launchType: launchType ?? SharedEnumFailureLaunchType.snackBar,
        );
}
