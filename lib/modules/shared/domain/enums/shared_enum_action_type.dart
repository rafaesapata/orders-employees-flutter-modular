// ignore_for_file: constant_identifier_names

enum SharedEnumActionType {
  APPSCREEN,
  EXTERNALURL;

  static SharedEnumActionType? toEnum(String? actionType) {
    switch (actionType) {
      case 'App_Screen':
        return SharedEnumActionType.APPSCREEN;
      case 'External_URL':
        return SharedEnumActionType.EXTERNALURL;
      default:
        return null;
    }
  }
}
