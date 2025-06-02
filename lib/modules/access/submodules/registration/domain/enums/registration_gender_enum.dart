import '../../../../../../app/app_localization.dart';

enum RegistrationGenderEnum { masculine, feminine, other }

extension RegistrationGenderEnumSetup on RegistrationGenderEnum {
  String get description {
    switch (this) {
      case RegistrationGenderEnum.masculine:
        return Localization.tr.registrationGenderMasculine;
      case RegistrationGenderEnum.feminine:
        return Localization.tr.registrationGenderFeminine;
      case RegistrationGenderEnum.other:
        return Localization.tr.registrationGenderOther;
    }
  }
}
