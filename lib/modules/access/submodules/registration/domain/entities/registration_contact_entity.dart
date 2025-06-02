abstract class RegistrationContactEntity {
  final String email;
  final String? phone;
  final String? cellphone;

  RegistrationContactEntity({
    required this.email,
    this.phone,
    this.cellphone,
  });
}
