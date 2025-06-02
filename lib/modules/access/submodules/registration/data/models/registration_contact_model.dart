import '../../domain/entities/registration_contact_entity.dart';

class RegistrationContactModel extends RegistrationContactEntity {
  RegistrationContactModel({
    required super.email,
    super.phone,
    super.cellphone,
  });
}
