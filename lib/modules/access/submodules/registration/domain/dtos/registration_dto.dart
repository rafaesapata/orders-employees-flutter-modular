import '../../data/models/registration_contact_model.dart';
import '../../data/models/registration_user_data_model.dart';

class RegistrationDTO {
  final String? name;
  final String? document;
  final String? gender;
  final String? email;
  final String? phone;
  final String? cellphone;
  final String? password;

  RegistrationDTO({
    this.name,
    this.document,
    this.gender,
    this.email,
    this.phone,
    this.cellphone,
    this.password,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'document': document,
        'gender': gender,
        'email': email,
        'phone': phone,
        'cellphone': cellphone,
        'password': password,
      };

  factory RegistrationDTO.fromSteps({
    RegistrationUserDataModel? userData,
    RegistrationContactModel? contactData,
    required String password,
  }) =>
      RegistrationDTO(
        name: userData?.name,
        document: userData?.document,
        gender: userData?.gender,
        email: contactData?.email,
        phone: contactData?.phone,
        cellphone: contactData?.cellphone,
      );
}
