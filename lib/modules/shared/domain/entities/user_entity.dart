abstract class UserEntity {
  final String? fullName;
  final String? maskedDocumentNumber;
  final String? birthdate;
  final bool? photoUrl;
  final bool? userName;
  final String? email;
  final String? cellPhone;
  final String? passwordUpdatedDate;
  final num? passwordErrorsAllowed;
  final String? id;
  final bool? isActive;
  final String? createDate;

  const UserEntity({
    this.fullName,
    this.maskedDocumentNumber,
    this.birthdate,
    this.photoUrl,
    this.userName,
    this.email,
    this.cellPhone,
    this.passwordUpdatedDate,
    this.passwordErrorsAllowed,
    this.id,
    this.isActive,
    this.createDate,
  });

  Map<String, dynamic> toMap();

  String toJson();
}
