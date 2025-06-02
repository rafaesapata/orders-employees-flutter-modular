enum SharedEnumFailureLaunchType { snackBar, bottomSheet }

extension SharedEnumFailureLaunchTypeExtension on SharedEnumFailureLaunchType {
  bool get isSnackBar => this == SharedEnumFailureLaunchType.snackBar;
  bool get isBottomSheet => this == SharedEnumFailureLaunchType.bottomSheet;
}
